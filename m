From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2+: omap_hwmod: Introduce ti,no-init dt
 property
Date: Wed, 11 Mar 2015 18:32:02 +0200
Message-ID: <55006E02.8040904@ti.com>
References: <1425561211-31003-1-git-send-email-d-gerlach@ti.com> <1425561211-31003-2-git-send-email-d-gerlach@ti.com> <alpine.DEB.2.02.1503051815590.5613@utopia.booyaka.com> <20150305184952.GF13520@atomide.com> <54F8B2C7.7060202@ti.com> <20150305201713.GH13520@atomide.com> <20150306004157.GI13520@atomide.com> <54F9E3BF.5010407@ti.com> <20150306174548.GW13520@atomide.com> <54FF2BA5.6070001@ti.com> <54FF30F4.10107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48795 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259AbbCKQce (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2015 12:32:34 -0400
In-Reply-To: <54FF30F4.10107@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, KEERTHY <j-keerthy@ti.com>

Hi Dave,

On 03/10/2015 07:59 PM, Dave Gerlach wrote:
> On 03/10/2015 12:36 PM, Grygorii Strashko wrote:
>> On 03/06/2015 07:45 PM, Tony Lindgren wrote:
>>> * Dave Gerlach <d-gerlach@ti.com> [150306 09:28]:
>>>> On 03/05/2015 06:41 PM, Tony Lindgren wrote:
>>>>> * Tony Lindgren <tony@atomide.com> [150305 12:24]:
>>>>>> * Dave Gerlach <d-gerlach@ti.com> [150305 11:53]:
>>>>>>> On 03/05/2015 12:49 PM, Tony Lindgren wrote:
>>>>>>>> * Paul Walmsley <paul@pwsan.com> [150305 10:16]:
>>>>>>>>> On Thu, 5 Mar 2015, Dave Gerlach wrote:
>>>>>>>>>
>>>>>>>>>> Introduce a dt property, ti,no-init, that prevents hwmod ini=
tialization.
>>>>>>>>>> Even if a dt node is marked as disabled, hwmod still at leas=
t enables
>>>>>>>>>> the hwmod and programs the sysconfig before attempting to id=
le it at
>>>>>>>>>> boot. If an IP has been disabled by the hardware configurati=
on on a
>>>>>>>>>> platform, this will cause a hang due to writing to inactive =
registers.
>>>>>>>>>> This property prevents that from happening by marking the hw=
mod as
>>>>>>>>>> _HWMOD_STATE_DISABLED during init.
>>>>>>>>>
>>>>>>>>> I'm kind of wondering if hwmod should even touch a device if =
it's marked
>>>>>>>>> as disabled in the DT.  Tony, what do you think?
>>>>>>>>
>>>>>>>> Well nothing happens if a device is status =3D "disabled". No =
dev entry
>>>>>>>> gets created for it at all and hwmod won't have any data for t=
he device
>>>>>>>> populated. The only way hwmod code could see that device if th=
e device
>>>>>>>> gets it's data from the legacy omap_hwmod_*_data.c instead of =
DT.
>>>>>>>>
>>>>>>>
>>>>>>> We still need this for the sysconfig programming, correct? hwmo=
d programs that
>>>>>>> regardless of dt status and then idles the IP,
>>>>>>
>>>>>> Well hwmod does not even know about the IP IO addresses if it's =
marked
>>>>>> with status =3D "disabled".. Which IP are you having problems wi=
th?
>>>>>>
>>>>>>> which is why I needed the ti,no-init for the epos evm. It isn't=
 just a
>>>>>>> matter of we shouldnt write to it because we don't want to use =
it; we
>>>>>>> can't write to it because the module is held off so it causes a=
n
>>>>>>> external abort if we do.
>>>>>>
>>>>>> Well hard to say not knowing which module this is.. Pretty much =
all
>>>>>> the modules have drivers and the driver just does pm_runtime_get=
()
>>>>>> on it?
>>>>>
>>>>> Heh OK this thread is about the RTC driver, so I assume that's th=
e
>>>>> problem :) So if you set the rtc to status =3D "disabled" how can=
 the
>>>>> hwmod code do anything as AFAIK it won't even get the rtc IO addr=
ess?
>>>>>
>>>>> Or am I missing something here?
>>>>
>>>> Perhaps I am mistaken, but from what I understand, all hwmods have=
 _init and
>>>> _setup called on them, and all hwmods read the IO address regardle=
ss of DT
>>>> status at this point with _init_mpu_rt_base. In _setup, _setup_res=
et gets called
>>>> which calls _enable for the hwmod, and this calls both _enable_sys=
c and
>>>> _update_sysc_cache which touch the sysconfig register of the IP.

And that's the problem :) What ePar says:
=93disabled=94 - Indicates that the device is not presently operational=
, but it might
become operational in the future (for example, something is not plugged=
 in, or switched off).

and current OF implementation will not register corresponding device
in DD core and, as result, drivers will be never ever bound with these =
devices.
As i said before, such devices are invisible/absent/not present, so
there are no reasons to touch them at all in Kernel, because result is =
unpredictable
in general. And there are no guarantee that there will be no other issu=
es,=20
even if you'll fix this particular case.=20

>>>
>>> Oh OK, I think you're right. I was thinking of omap_device_build_fr=
om_dt(),
>>> sorry. Looks like the hwmod IO address data does get populated even
>>> for status =3D "disabled" although the dev entry won't get created =
and
>>> omap_device_build_from_dt() never gets called.
>>>
>>>> Normally this is fine regardless of whether or not we are using an=
 IP because
>>>> the module will wake up for a moment, have it's sysc programmed, a=
nd then be put
>>>> back to sleep later, potentially never to be woken again if we bin=
d no driver
>>>> for it, which is fine for 99% of cases. In the case of am43x epos =
evm, you can

^^ if status=3D=93disabled=94/"failed" there will be no device and no d=
river will have been bound :)

>>>> take the same piece of silicon that will boot happily on the gp ev=
m with the rtc
>>>> hwmod in place and it will hang during boot on the epos evm becaus=
e the board
>>>> uses a pin to hold the RTC IP in reset. There is no way to detect =
this in
>>>> software, the module can be turned on as normal using the clk_ctrl=
, but if you
>>>> touch any of the IP registers you get an abort.
>>>
>>> OK sounds like some dts property is needed to signal this.

Seems It might be much more simple to just remove RTC device from DT, a=
s=20
it's disabled and unaccessible =3D=3D not present:
- add am4372-rtc.dtsi and put RTC device definition there
- include am4372-rtc.dtsi in board files where allowed


>>
>> As I understand, there is device "RTC" and this device has status 'd=
isabled',
>> so there is reasonable question why do we need to touch it at all?
>> The HWMOD is some kind of SoC description, which was needed before D=
T.
>> Now with DT in place it seems unreasonable to touch any IP block whi=
ch:
>> - are not defined in DT
>> - has status 'disabled'.
>> in above cases the u-boot has to dial with IP block if it's invisibl=
e for Kernel.
>>
>> The HWMOD framework intended to reset and put in some predefined sta=
tes IPs which are
>> visible for the Kernel, so then proper driver can start working with=
 IP or IP will be
>> kept in some low-power state if there is no driver.
>=20
> Currently we still need this hwmod behavior as not all IPs are in an =
ideal state
> for PM by default. Not sure if you saw my last email in this thread b=
ut I gave
> an example for USB hwmod:
>=20
> If no USB driver is bound even just letting omap_device idle it using=
 the USB_
> CLKCTRL in the PRCM will not work properly, because the USB on am33xx=
 expects
> it's SYSCONFIG STANDBY_MODE to be software supervised, the default st=
ate
> (SMART_STANDBY) does not let the IP go into standby so the IP gets st=
uck in a
> partially off state but does not actually shut down as expected.
>=20
> So we need to be able to touch the dt nodes even if they are marked a=
s disabled
> because we need to get the IO address to have access to the SYSCONFIG=
 register.
> I am not trying to introduce any major new changes to omap_hwmod laye=
r, I am
> just trying to allow it to work in more situations.


Oh yes! And this happen just due to historical reasons ;)=20
The HWMOD is ancient thing :P which was created at time when:
- all OMAP's code was built-in
- there were no DT in place.
And it actually was created to describe configuration and integration o=
f HW.
But now there is DT which is intended for the same purposes and HWMOD d=
ata is
still here (as i know) just because process of migration to DT is not f=
ully completed yet.
More over, now we have multiplatform; restriction to put SoC's erratas =
and hacks in kernel;
and all drivers going to be converted to loadable modules.

In my opinion, this is not good when we have device marked as 'disabled=
',
but Kernel still tries to access them. More over, we need to completely=
 remove device's
definitions from DT to prevent Kernel of touching such devices.

So, let's not make things worse than they are :( and just remove RTC de=
vice where it's not needed.

>=20
> This flag would only exist to PREVENT any hwmod action from happening=
 in certain
> cases where we cannot even touch the IP for whatever reason (in the f=
irst case
> that this patch intends to be used for, the RTC IP on am43x-epos-evm =
which is
> disabled by the board configuration).
>=20
>>
>> Such kind of changes really confused :(, because when I'm looking on=
 DT and see - status=3D'disabled'
>> I suppose that such IP will not be touched by Kernel. But it's NOT r=
eally 'disabled'.
>> It's kinda 'partially disabled' or 'not present' or 'unused' ..
>> (if someone will decide to continue with such approach - it could be=
 more
>> useful to define new value for 'status' parameter :P).
>> Also, just imaging that OMAP kernel is used with Xen as DomU and how=
 hard will
>> it be to find and cut off all such tricks :(
>>
>> Did I miss something?
>>
>>>   =20
>>>> So we need to prevent this from happening but of course we can't s=
electively
>>>> choose when the rtc hwmod gets added based on which board we are u=
sing so it
>>>> seemed a DT flag was appropriate to indicate that we do not want t=
o init the rtc
>>>> IP at all only on this board.
>>>>
>>>> Without this flag in place but with the rtc hwmod added, the am43x=
-epos-evm
>>>> fails booting with an imprecise abort.
>>>
>>> OK thanks for explaining it. I'm fine with this patch, Paul may hav=
e
>>> other issues. The other option would be to use status =3D "disabled=
" to
>>> not touch the device at all like Paul suggested. I wonder if that's
>>> going to break PM on some devices though..

That how it should be as for me, but unfortunately, it could break PM :=
(,=20
because It's common assumption now that Kernel will
reset & disable ALL OMAP's devices regardless of DT.=20

It could be possible if it will be handled properly outside of
the kernel - in u-boot for example.

regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
