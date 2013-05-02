From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: Latest build results - errors/warnings - lots of them
Date: Thu, 2 May 2013 13:07:49 -0400
Message-ID: <51829D65.7040109@ti.com>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk> <20130502082218.GA21614@n2100.arm.linux.org.uk> <20130502153834.GR28721@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2RVRTDHNQSUKEXJOGHURI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58064 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757385Ab3EBRIy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 May 2013 13:08:54 -0400
In-Reply-To: <20130502153834.GR28721@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Eduardo Valentin <eduardo.valentin@ti.com>, Neil Brown <neilb@suse.de>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Durgadoss R <durgadoss.r@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

------enig2RVRTDHNQSUKEXJOGHURI
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Arnd, Tony,

On 02-05-2013 11:38, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [130502 01:27]:
>> On Tue, Apr 30, 2013 at 09:17:39AM +0100, Russell King - ARM Linux wro=
te:
>>> Latest nightly build of 3.9+my for-next+arm-soc's for-next results in=
 a
>>> great load of new warnings and errors.  arch/arm/common/mcpm_head.S,
>>> arch/arm/common/mcpm_platsmp.c, arch/arm/common/vlock.S are the bigge=
st
>>> source of errors.
>>>
>>> OMAP stuff needs a serious look at too - much Kconfig madness there
>>> caused by over-use of select, which then goes on to cause build error=
s
>>> because it assumes some stuff is always enabled.
>>>
>>> There's also warnings about of_device_id from include/linux/of_platfo=
rm.h
>>> via from arch/arm/kernel/setup.c which feature in all the non-OF buil=
ds
>>> too which need addressing.
>>>
>>> See todays http://www.arm.linux.org.uk/developer/build/ results for a=
ll
>>> the details and configs.  Not pushing my tree until some of this stuf=
f
>>> gets fixed.
>>
>> And now we have a new bunch of warnings from OMAP stuff which weren't
>> previously there...
>>
>> arch/arm/mach-omap2/omap_device.c: In function 'omap_device_get_by_hwm=
od_name':
>> arch/arm/mach-omap2/omap_device.c:821:3: warning: return makes pointer=
 from integer without a cast
>> arch/arm/mach-omap2/omap_device.c:826:3: warning: return makes pointer=
 from integer without a cast
>=20
> Hmm these I already fixed earlier along with a merge resolution, and
> I'm not seeing them in next/master or arm-soc/for-next. What do you
> have merged into your current tree?
>=20
>> drivers/power/twl4030_charger.c: In function 'twl4030_charger_enable_u=
sb':
>> drivers/power/twl4030_charger.c:192:20: warning: ignoring return value=
 of 'regulator_enable', declared with attribute warn_unused_result
>=20
> Neil, care to provide a fix for this? It's from your commit ab37813
> (twl4030_charger: Allow charger to control the regulator that feeds it)=
=2E
>=20
>> include/linux/thermal.h:254:12: warning: 'thermal_generate_netlink_eve=
nt' defined but not used
>=20
> Eduardo, can you fix that one? It seems to be from your commit 8ab3e6a
> (thermal: Use thermal zone device id in netlink messages).

Yeah sure I can fix it. As simple as the following:
=46rom c04244c87312f5bfc61d9e12ba3fbaa0fdd81adb Mon Sep 17 00:00:00 2001
From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Thu, 2 May 2013 12:58:20 -0400
Subject: [PATCH 1/1] thermal: remove stub for thermal_generate_netlink_ev=
ent

This patch removes the stub for thermal_generate_netlink_event
because this function is not used anywhere inside the kernel.

In case CONFIG_NET is not set we get:
include/linux/thermal.h:254:12: warning:
'thermal_generate_netlink_event' defined but not used

Thus removing it.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 include/linux/thermal.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e3c0ae9..e3f3cba 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -250,12 +250,6 @@ void thermal_unregister_governor(struct
thermal_governor *);
 #ifdef CONFIG_NET
 extern int thermal_generate_netlink_event(struct thermal_zone_device *tz=
,
 						enum events event);
-#else
-static int thermal_generate_netlink_event(struct thermal_zone_device *tz=
,
-						enum events event)
-{
-	return 0;
-}
 #endif

 #endif /* __THERMAL_H__ */
--=20
1.8.2.1.342.gfa7285d

However,...

Rui, Durga,

 That function was used in the previous thermal  layer design. Now the
notification is done via sysfs, not netlink. The netlink interface needs
to be flagged as DEPRECATED and then we would remove it.

In any case, the above function is used by no one within the kernel:
$ git grep thermal_generate_netlink_event
Documentation/thermal/sysfs-api.txt:just need to call
thermal_generate_netlink_event() with two arguments viz
drivers/thermal/thermal_core.c:int thermal_generate_netlink_event(struct
thermal_zone_device *tz,
drivers/thermal/thermal_core.c:EXPORT_SYMBOL_GPL(thermal_generate_netlink=
_event);
include/linux/thermal.h:extern int thermal_generate_netlink_event(struct
thermal_zone_device *tz,
include/linux/thermal.h:static inline int
thermal_generate_netlink_event(struct thermal_zone_device *tz,


For that reason, I d propose to simply remove it, as I do not have any
user space application that uses that net link interface. But that needs
a confirmation from the Intel folks.

Rui, Durga? Last merge window we discussed to remove this API, do you
guys have dependency on this one still?


Cheers,

>=20
> Regards,
>=20
> Tony
>=20
>=20



------enig2RVRTDHNQSUKEXJOGHURI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlGCnWUACgkQCXcVR3XQvP2Z7QD9FtmJ1sGtF8035Vt+rHIkfmWm
Rn6duTuGVwbFA9hax2wA/3kHif5+UM6pxx2Dd+EvCHaM3dQRa2nNQy4mtcD0UfgD
=YE31
-----END PGP SIGNATURE-----

------enig2RVRTDHNQSUKEXJOGHURI--
