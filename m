From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Mon, 19 May 2014 12:48:15 +0300
Message-ID: <5379D35F.8040207@ti.com>
References: <CABxcv==_LCw1kPYm17g=h8VfSN2V_qsgXjTnsy-JOetawSv4pA@mail.gmail.com> <20140513152518.GA16837@atomide.com> <53730AFB.2090800@ti.com> <20140514160216.GD18463@atomide.com> <537487AE.3060906@ti.com> <20140515182133.GC23659@atomide.com> <5375A8A8.7080306@ti.com> <20140516160717.GD22031@atomide.com> <20140516174158.GA11733@earth.universe> <20140516180154.GG22031@atomide.com> <20140516213907.GL12881@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="T4ovSsVSKhxSE9lC7fgtRILctMESTA36f"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59679 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbaESJsx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 05:48:53 -0400
In-Reply-To: <20140516213907.GL12881@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@ring0.de>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--T4ovSsVSKhxSE9lC7fgtRILctMESTA36f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/05/14 00:39, Tony Lindgren wrote:

>> AFAIK that remapping not needed at all. All that is already
>> available with the compatible flags.
>=20
> And alternatively we can also just use the sharp,ls037v7dw01
> in the panel driver(s). We can have the panels bail out in driver
> probe based on of_machine_is_compatible if nothing else is available.

I don't think that would work. Then we could have two panel drivers,
both loaded into the kernel and both having the same driver name and the
same compatible-string.

I'm not sure if it's even possible to load both of those drivers at the
same time, but if it was, and the first one would get probe() called for
a device, and the driver would return an error, I'm quite sure the
driver framework won't continue trying with the other driver, as the
first driver already matched for the device.

> Also, currently the remapping code also probably keeps prepending
> more and more omapdss,omapdss,omapdss,... on each kexec reboot? And

I don't think so. The code looks for, say, "ti,tfp410", and it wouldn't
match for "omapdss,ti,tfp410".

> it would be quite silly for each display controller to have to do
> their own remapping for shared panels?

It would, but wouldn't it be just as silly (well, even more silly in my
opinion) to have each display controller require driver specific
compatible strings for the panels used?

Until we have a common display framework, we need _some_ way to handle
this problem. Either we mess up the .dts files as you suggest, or we
have a driver internal hack.

> If we still still despite all these reasons decide to go with
> the remapping of the compatible strings, it should really be a
> Linux generic (or drivers/video generic function), not implemented
> for each display controller.

Well, I sure hope nobody else has to implement similar thing.

The reason why we have this code, and others do not, is mainly that
omapdss is maybe the first driver to implement the display components
properly, both in the SW side and in the .dts side, and that I wanted
omapdss to behave correctly even if there are other display
subsystems/panels compiled into the same kernel.

To open that up a bit, traditionally other display driver architectures
have not had drivers for each display "entity", like the panels. So you
would really just have the display subsystem in the .dts, and some raw
data there (panel timings) to get the panel running.

Now, with omapdss, we have separate drivers for each display entity.
Unfortunately those drivers are all tied to the omapdss driver's API
(and cannot thus be used on anything else than OMAP), as there's not yet
a driver framework for display entities (DRM is a bit different thing,
in my opinion).

Everything with that was simple with platform data, as the omap board
files created the panel devices, and there were no name clashing
problems with other platforms.

With DT that changed, as the bindings are common, and thus the
compatible strings are common also. But we still have omapdss specific
panel drivers. This is the reason we do the compatible-string conversion
hack. As soon as we can create platform agnostic panel drivers, we can
remove the hack.

And, I want to remind, it's an omapdss internal hack (after the patch I
sent), not visible to anyone else. The .dts files, the arch/arm files,
they are all not touched. So I don't quite understand why you see it as
such a bad thing. It's ugly, sure, but what harm does it do (except some
maintainer burden, for me)?

 Tomi



--T4ovSsVSKhxSE9lC7fgtRILctMESTA36f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTedNkAAoJEPo9qoy8lh71q2gP/2jSB9zSfp6WHvaX/j67/JLQ
dJO8AnrZR3agDjik9CZMsUr+7UntzEaJ+nNKK2vjVoDZzBAs5rq7Uv3/M2qrXXrW
P2nQ26tlOXNrtpWV9vGHY2mAbarwwLzX0/wjBGuSXI3U+vXnZcsVVMkm66RxLB65
sxVIoniJmItRtLtdkAlpLhjNFO6qqpvNhFIhT/mLySu0ohunBf/M0iUVyN5t1qKW
c3pfeYeXRLrFFxRzf37wzOQdAc9Hn/LSVs//sokqJdlJm79c7PLU4ZIBcPpMm1CF
SX2zZ8Bn2kW7PCSqzv1tCRFD/rt204D2nx0zg3g0eoYB8YKay73AQtUMNwXJ+p+3
NyLggUYlgm5SqIKvLy27GSTXfCFEQS846Me07cgBIRDelsLo4/WS90bE83PFlrDP
2XE84rVb2FglL4UNxmXJBVPrBe14ES762UjT4MJmgIGthfWdhWZhP1bmfpVULlJQ
vGrsppd85UEvNYc3DDviuO3BLhA3sWMTOfLmNy+Eu3GtBtXAlkEev4K8JIci2udy
2ytNBMD+9Mm97QvfVgLAnVfLA9dbNnk062l0O6ff+P08hK2d3yWazoyAhLLGYpSs
dLCZ7i3Y5JtbF838QnXCjnsIezJrMyInGU1TDf43H5qJZS4P0kAhFqEIOhTismxV
YzqRXfvam3JALYg/IRbG
=ffgp
-----END PGP SIGNATURE-----

--T4ovSsVSKhxSE9lC7fgtRILctMESTA36f--
