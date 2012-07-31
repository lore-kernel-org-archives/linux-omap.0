From: =?UTF-8?B?UmFwaGHDq2wgQXNzw6luYXQ=?= <raph@8d.com>
Subject: Re: [PATCH] OMAPDSS: Do not require a VDDS_DSI regulator on am35xx
Date: Tue, 31 Jul 2012 16:46:33 -0400
Message-ID: <50184429.4030103@8d.com>
References: <20120719200429.GD3850@renkinjitsu.usine.8d.com> <1343724323.2633.22.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:43198 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154Ab2GaUqg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 16:46:36 -0400
In-Reply-To: <1343724323.2633.22.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

On 31/07/12 04:45 AM, Tomi Valkeinen wrote:
> On Thu, 2012-07-19 at 16:04 -0400, Raphael Assenat wrote:
>> On our AM3505 based board, dpi.c complains that there is no VDSS_DSI=
 regulator
>> and the framebuffer cannot be enabled. However, this check does not =
seem to
>> apply to AM3505/17 chips.
>>
>> I am not the first facing this issue, see this thread from Nov. 2011=
:
>> http://marc.info/?l=3Dlinux-omap&m=3D132147745930213&w=3D2
>>
>> The string 'vdds_dsi' does appear once in the technical reference ma=
nual[1]
>> but there is no corresponding power pin on the package[2]. I failed =
to=20
>> locate any signal that could be an equivalent. I am trying to obtain=
 some
>> clarifications on TI's forum[3]...
>>
>> In any case, I am currently running with the patch below. In order t=
o keep
>> cpu_is_xx uses to a minimum, I check for am35xx once at init time an=
d allow
>> dpi.vdds_dsi_reg to be NULL from then on, getting rid of all the oth=
er
>> cpu_is_omap34xx uses in the process.
>>
>> Your comments would be appreciated. Please also consider for merging=
=2E
>=20
> VDDS_DSI is used to power up some of the DSS pins on OMAP3. I don't k=
now
> why the HW was designed like that... If you have a correct image with=
out
> the power, then obviously it's not needed.

Yes, I confirm the image is displayed properly.

> We don't currently deal with AM3xxx SoCs in any way in the driver. It=
's
> difficult enough trying to handle just OMAP DSS versions, and now we
> need to add AM3xxx to the mix. Sigh =3D).
>=20
> However, I don't want to apply this patch, as we're trying to remove =
the
> cpu_is checks (soc_is goes in the same category).
>=20
> I guess we need to add entries for the AM3xxx SoCs in the
> dss_features.c.
>=20
> Any idea what other differences AM3xxx has compared to OMAP3?

This is the only one I am aware of.


Best regards,
Rapha=C3=ABl Ass=C3=A9nat
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
