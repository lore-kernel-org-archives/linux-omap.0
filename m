From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 12/12] OMAPDSS: DPI: always use DSI PLL if available
Date: Wed, 7 Nov 2012 12:01:21 +0200
Message-ID: <509A3171.8010100@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-13-git-send-email-tomi.valkeinen@ti.com> <5090D28E.6050703@ti.com> <50939B84.6090602@ti.com> <5093A3FB.1060806@ti.com> <5093A530.5050302@ti.com> <5093A9E8.70106@ti.com> <5093AE79.9010603@ti.com> <5093B4F3.1000703@ti.com> <50977EEF.3040403@ti.com> <5097CB81.7050204@ti.com> <509913A4.5080408@iki.fi> <CAF6AEGuNyqO-teda1sv8c8m9x1j8Fm13HYuWB4N3gccJeKFTFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig62730C598A176A43CDACCAD9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58734 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753909Ab2KGKBg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 05:01:36 -0500
In-Reply-To: <CAF6AEGuNyqO-teda1sv8c8m9x1j8Fm13HYuWB4N3gccJeKFTFg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: Tomi Valkeinen <tomba@iki.fi>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

--------------enig62730C598A176A43CDACCAD9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-06 16:40, Rob Clark wrote:

> I mean, similar to how we handle the subdev for dmm..  the
> omap_drm_init() does the platform_driver_register() for the dmm device
> before the platform_driver_register() for omapdrm itself, so we know
> if there is a dmm device, the driver gets probed first before omapdrm.

Well, I consider that a bit hacky too. That's not how linux device
framework is supposed to be used. I know it makes life easier to do the
registering like that, though.

> It could be a matter of iterating through a list, or something like
> this.. that is basically an implementation detail.  But the end result
> is that the order the drivers are registered is controlled so the
> probe sequence works out properly (not to mention suspend/resume
> sequence).

I feel that this kind of solution just tries to solve the generic
problem of init/suspend ordering in a single driver, instead of fixing
the device framework itself.

Or, of course it's possible that our drive architecture just sucks, and
the device framework is fine. In that case the workaround is even worse,
and we should fix our drivers.

>> I think we should support proper hotplugging of the panels. This would=

>> fix the problem about init order, but it would also give us device
>> hotplug support. Obviously nobody is going to solder panel to a runnin=
g
>> board, but I don't see any reason why panels, or, more likely, panels =
on
>> an add-on boards (like the capes being discussed in omap ml) would not=

>> be hotpluggable using whatever connector is used on the particular use=
 case.
>>
>> And even if we don't support removing of the devices, things like the
>> add-on capes could cause the panel on the cape to be identified at som=
e
>> late time (the panel is not described in the board file or DT data, bu=
t
>> found at runtime depending on the ID of the cape). This would add
>> another step to the init sequence that should be just right, if we don=
't
>> support hotplug.
>=20
> If capes are really hot-pluggable, then maybe it is worth thinking
> about how to make this more dynamic.  Although it is a bigger problem,
> which involves userspace being aware that connectors can dynamically
> appear/disappear.  And the dynamic disappearing is something I worry
> about more.. it adds the possibility of all sorts of interesting race
> conditions, such as connectors disappearing in the middle of modeset.
> I prefer not making things more complicated and error prone than they
> need to be.  If there is not a legitimate use case for connector hw
> dynamically appearing/disappearing then I don't think we should go
> there.  It sounds nice and simple and clean, but in reality I think it
> just introduces a whole lot of ways for things to go wrong.  A wise

Yes, I agree that it complicates things.

> man once said:
>=20
> https://github.com/robclark/kernel-omap4/blob/master/Documentation/Subm=
ittingPatches#L700

I've done things simple lots of times in the omapdss driver, only to
have to rewrite the thing in more complex way later to accommodate new
scenarios. I think it's good to write the code in a bit more generic way
than the use case at the moment of writing requires, because more often
than not, it'll save time in the future.

Hotplugging is not some abstract future scenario, we already have
hardware that could use it. For example, omap3 SDP board has a
switchable output to DVI or LCD panel. In this case we know what the two
options are, but the disabled component is still effectually removed
from the system, and plugged back in when it's enabled.

Hotplug is not a high priority item, but I do wish we get it supported
in common panel framework. Then it's at least possible to extend drm in
the future to support it.



Anyway, this makes me wonder... omapdrm currently maps the elements of
the whole video pipeline to drm elements (encoder, connector, etc).
Would it make more sense to just map the DISPC to these drm elements?
Connector would then be the output from DISPC.

This would map the drm elements to the static hardware blocks, and the
meaning of those blocks would be quite similar to what they are in the
desktop world (I guess).

The panel driver, the external chips, and the DSS internal output blocks
(dsi, dpi, ...) would be handled separately from those drm elements. The
DSS internal blocks are static, of course, but they can be effectively
considered the same way as external chips.

The omapdrm driver needs of course to access those separate elements
also, but that shouldn't be a problem. If omapdrm needs to call a
function in the panel driver, all it needs to do is go through the chain
to find the panel. Well, except if one output connected two two panels
via a bridge chip...

And if drm is at some point extended to support panel drivers, or chains
of external display entities, it would be easier to add that support.

What would it require the manage the elements like that? Would it help?
It sounds to me that this would simplify the model.

 Tomi



--------------enig62730C598A176A43CDACCAD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQmjFxAAoJEPo9qoy8lh717LQP/1YNhqG8muCrKUMN7rSueHWc
mdq10UeDjVXlNgtIR3AMZZAY02bvW56qRjd6nTmYSpNYL6SJB6iOVVDk+vJFduKO
rnTDMTG+yphYHc8cw+uNhOTDMyG7/J5wA0ScWFxqVcdGEmTIuqbSIcx3CAk6w3mj
kV6V8JXrGCjS+2854sT8/VjVjrPDuU4HWd2zDfGP1RcPqQeZ5LUjLqI/vdShaJ70
q2R6mkwdpy3FA2pHmhqzf+9tTykOtr4NE2ee02R0OSV22ekkjCRM9Lq5um/TNJ9z
swnHwMZNuTkEjtCw7WGRDsSUVppIH5bTsXR1hx6Yyba2F36uQGFvPDQocS1/ApiJ
sqNvkfb1GIrI7lCD4RP7uRljrBp96pRs5mOM5Wc6kOVr203Z+/8yhcliDY3dwqPv
5yYbyaGy/RR1Gsp9rmH7EJPDZ82+/i6zbZrSDjJjalBBZH1wfkgnN7NzSe0xL24+
DLDmx7xHnthDIv88ugqe7WfryR1KBug0SJZNp3fOqU5lo/e2Q52LBUXe2MdVgzQq
ZqBIAjlW3InT/Ipo/EroD9CTT21Nhuupgvw9/5ppkuYv0yy6WKb+pk3YitKJq1hW
hXDAHTHTdL62rAdJlMM5Qc0ClMLD8kyGDzvExvgAfkzVFizcH/HYQAZ6Mda2fZVB
/MwUKEfg8xWZ4eYkRfWN
=GKqO
-----END PGP SIGNATURE-----

--------------enig62730C598A176A43CDACCAD9--
