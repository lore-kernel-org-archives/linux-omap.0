From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
Date: Fri, 15 Apr 2016 22:50:14 +0300
Message-ID: <571145F6.2040508@ti.com>
References: <20160411212845.GJ5995@atomide.com> <570CC54E.6020703@ti.com>
 <20160412163750.GR5995@atomide.com> <570E3428.5020804@ti.com>
 <20160413152829.GQ5995@atomide.com> <570F4804.4050006@ti.com>
 <20160414165514.GL5995@atomide.com> <570FF163.1050603@ti.com>
 <20160414203457.GM5995@atomide.com> <5710C10A.6040908@ti.com>
 <20160415151651.GP5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160415151651.GP5995-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/15/2016 06:16 PM, Tony Lindgren wrote:
>> The hwmod checks the bits described by prcm.omap2. If two hwmods are=
 set up to
>> manage/monitor the same bits in PRCM, what will happen when the two =
driver
>> does pm_runtime?
>>
>> CM_ICLKEN_PER[0] =3D 1
>> McBSP2: runtime_get_sync()
>> CM_ICLKEN_PER[0] =3D 0
>> ...
>> CM_ICLKEN_PER[0] =3D 0
>> McBSP2.ST: runtime_get_sync() // hwmod might complain as the idlest =
was not 1?
>> CM_ICLKEN_PER[0] =3D 0
>> ...
>> CM_ICLKEN_PER[0] =3D 0
>> McBSP2.ST: runtime_put_sync()
>> CM_ICLKEN_PER[0] =3D 0 // hwmod might warn that the module did not w=
ent idle?
>> ...
>> CM_ICLKEN_PER[0] =3D 0
>> McBSP2: runtime_put_sync()
>> CM_ICLKEN_PER[0] =3D 1
>>
>> We can hack this around by adding HWMOD_NO_IDLEST to the sidetone hw=
mod I
>> guess. As the sidetone does not have PRCM level control - it is part=
 of McBSP.
>=20
> Heh if they are using the same register bits for two separate modules=
,
> then that's a bug for sure :) I think the sidetone module only has th=
e
> clock gating bit in the ST_SYSCONFIG.

Yes, the sidetone only has clock gating bit in ST_SYSCONFIG, but the hw=
mod has
the prcm section which is identical of the corresponding McBSP hwmod pr=
cm section.

Since we have only one MCBSP2_ICLK and only one bit in PRCM registers f=
or it,
this is a bug in the hwmod data for sure. Only the mcbsp hwmod should h=
ave
prcm section and the sidetone hwmod is not needed IMO:
It is a bug to have sidetone enabled when McBSP is not enabled and conf=
igured
properly. The sidetone can not work w/o proper McBSP configuration.

If we were to keep both hwmods and add new set of pm_runtime calls for =
the
mcbsp.sidetone, it will only increase/decrease the mcbsp_iclk enable co=
unt. It
must never enable the clock itself since that is a bug in the SW.

>>> Then there are two separate sets of sysconfig registers that PM run=
time should manage.
>>
>> The sidetone core's sysconfig register is internal to McBSP module. =
This is
>> what the TRM has to say about McBSPi.ST_SYSCONFIG_REG[0] AUTOIDLE bi=
t:
>> - When this bit is asserted (set to 1), the McBSPi_ICLK clock auto-g=
ating is
>> enabled and this clock is disabled internally to the SIDETONE featur=
e, thus
>> reducing power consumption, but not to the McBSP module that contain=
s this
>> feature.
>=20
> Some confusion here.. The McBSPi_ICLK is external, it's just shared
> between the McBSP and sidetone modules. So the ST_SYSCONFIG gates
> internally separately to the sidetone.

I think it is called McBSPi_ICLK internally also, but true. The same cl=
ock
from PRCM goes to McBSPi core and McBSPi.sidetone core. The only differ=
ence is
that the sidetone is only able to gate the clock internally.

>> After reset, the automatic clock gating is enabled; thus, this bit m=
ust be
>> disabled by software for activated SIDETONE feature.
>> - When this bit is set to 0, the McBSPi_ICLK clock auto-gating is di=
sabled and
>> this clock is enabled. The SIDETONE feature can be used normally.
>>
>> The ST_SYSCONFIG_REG is internal to the McBSP module the ST is integ=
rated into.
>=20
> The ST_SYSCONFIG is internal to the sidetone module only. Then the
> McBSP module has it's own SYSCONFIG register that's internal to the
> McBSP module only.

And the McBSP core can signal (ack) the PRCM back, but the sidetone cor=
e can not.

> I think the confusion comes from the McBSPi_ICLK naming, that's not
> internal to the module(s) in question, it comes from an external
> shared source that the SYSCONFIG registers control.
>=20
> Some SYSCONFIG registers have autoidle features that signal the
> source clockdomain too.
>=20
>> I'm still not convinced about the benefits of creating separate devi=
ce for the
>> ST core of McBSP.
>> From my point of view:
>> McBSP2 module consist of:
>> - McBSP core
>>  - clock generator subcore
>>  - tx subcore
>>  - rx subcore
>> - Sidetone core
>=20
> I think it's more like this for the clocking and
> intermodule lines:
>=20
> clockdomain
> clock generarator ---+
> subcore              |
>                      +- McBSP
>                      |  internal gating
>                      |  and signaling to
>                      |  clockdomain via
>                      |  SYSCONFIG register
>                      |        | |
>                      |        | | intermodule lines
>                      |        | | not on the interconnect
>                      |        | |
>                      +- sidetone
>                      |  internal gating
>                      |  (and signaling to
>                      |  clockdomain via
>                      |  SYSCONFIG register?)
>=20
> Then all these modules just sit on the L4 interconnet at
> separate targets, including the clockdomain.

The McBSPi core and it's sidetone is in the same clock domain as the si=
detone
is using the McBSPi interface clock. It is kind of a leech ;)
It is more like:

clockdomain
clock generator ---+
subcore            |
                   +--+--McBSP2
                   |  |
                   |  |
                   |  McBSP2_sidetone


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
