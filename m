From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: Latest build results - errors/warnings - lots of them
Date: Thu, 2 May 2013 14:46:31 -0400
Message-ID: <5182B487.7090801@ti.com>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk> <20130502082218.GA21614@n2100.arm.linux.org.uk> <20130502153834.GR28721@atomide.com> <51829D65.7040109@ti.com> <20130502180627.GA10672@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2FNRTXNBJAOPQWJRHUNRS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36948 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761462Ab3EBSrQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 May 2013 14:47:16 -0400
In-Reply-To: <20130502180627.GA10672@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Neil Brown <neilb@suse.de>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Durgadoss R <durgadoss.r@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

------enig2FNRTXNBJAOPQWJRHUNRS
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02-05-2013 14:06, Felipe Balbi wrote:
> Hi,
>=20
> On Thu, May 02, 2013 at 01:07:49PM -0400, Eduardo Valentin wrote:
>> Arnd, Tony,
>>
>> On 02-05-2013 11:38, Tony Lindgren wrote:
>>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [130502 01:27]:
>>>> On Tue, Apr 30, 2013 at 09:17:39AM +0100, Russell King - ARM Linux w=
rote:
>>>>> Latest nightly build of 3.9+my for-next+arm-soc's for-next results =
in a
>>>>> great load of new warnings and errors.  arch/arm/common/mcpm_head.S=
,
>>>>> arch/arm/common/mcpm_platsmp.c, arch/arm/common/vlock.S are the big=
gest
>>>>> source of errors.
>>>>>
>>>>> OMAP stuff needs a serious look at too - much Kconfig madness there=

>>>>> caused by over-use of select, which then goes on to cause build err=
ors
>>>>> because it assumes some stuff is always enabled.
>>>>>
>>>>> There's also warnings about of_device_id from include/linux/of_plat=
form.h
>>>>> via from arch/arm/kernel/setup.c which feature in all the non-OF bu=
ilds
>>>>> too which need addressing.
>>>>>
>>>>> See todays http://www.arm.linux.org.uk/developer/build/ results for=
 all
>>>>> the details and configs.  Not pushing my tree until some of this st=
uff
>>>>> gets fixed.
>>>>
>>>> And now we have a new bunch of warnings from OMAP stuff which weren'=
t
>>>> previously there...
>>>>
>>>> arch/arm/mach-omap2/omap_device.c: In function 'omap_device_get_by_h=
wmod_name':
>>>> arch/arm/mach-omap2/omap_device.c:821:3: warning: return makes point=
er from integer without a cast
>>>> arch/arm/mach-omap2/omap_device.c:826:3: warning: return makes point=
er from integer without a cast
>>>
>>> Hmm these I already fixed earlier along with a merge resolution, and
>>> I'm not seeing them in next/master or arm-soc/for-next. What do you
>>> have merged into your current tree?
>>>
>>>> drivers/power/twl4030_charger.c: In function 'twl4030_charger_enable=
_usb':
>>>> drivers/power/twl4030_charger.c:192:20: warning: ignoring return val=
ue of 'regulator_enable', declared with attribute warn_unused_result
>>>
>>> Neil, care to provide a fix for this? It's from your commit ab37813
>>> (twl4030_charger: Allow charger to control the regulator that feeds i=
t).
>>>
>>>> include/linux/thermal.h:254:12: warning: 'thermal_generate_netlink_e=
vent' defined but not used
>>>
>>> Eduardo, can you fix that one? It seems to be from your commit 8ab3e6=
a
>>> (thermal: Use thermal zone device id in netlink messages).
>>
>> Yeah sure I can fix it. As simple as the following:
>> From c04244c87312f5bfc61d9e12ba3fbaa0fdd81adb Mon Sep 17 00:00:00 2001=

>> From: Eduardo Valentin <eduardo.valentin@ti.com>
>> Date: Thu, 2 May 2013 12:58:20 -0400
>> Subject: [PATCH 1/1] thermal: remove stub for thermal_generate_netlink=
_event
>>
>> This patch removes the stub for thermal_generate_netlink_event
>> because this function is not used anywhere inside the kernel.
>>
>> In case CONFIG_NET is not set we get:
>> include/linux/thermal.h:254:12: warning:
>> 'thermal_generate_netlink_event' defined but not used
>>
>> Thus removing it.
>>
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>> ---
>>  include/linux/thermal.h | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index e3c0ae9..e3f3cba 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -250,12 +250,6 @@ void thermal_unregister_governor(struct
>> thermal_governor *);
>>  #ifdef CONFIG_NET
>>  extern int thermal_generate_netlink_event(struct thermal_zone_device =
*tz,
>>  						enum events event);
>> -#else
>> -static int thermal_generate_netlink_event(struct thermal_zone_device =
*tz,
>=20
> just adding 'inline' would be an easier patch and lets you compile fine=

> on !CONFIG_NET when you starting using thermal_generate_netlink_event()=
=2E
>=20

Yeah, that is one thing. But as I pointed, the fix is actually to remove
the whole netlink thing.


------enig2FNRTXNBJAOPQWJRHUNRS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGCtIcACgkQCXcVR3XQvP1PDgD8CAba7iUr8KPRldtxCXY5mdYf
6hAaRCiaoxXbAI0UwLcA/iLBC++YPauPkFB/SpfdVjrZWeRtvMHQVBgXV/q1hgTe
=ukmk
-----END PGP SIGNATURE-----

------enig2FNRTXNBJAOPQWJRHUNRS--
