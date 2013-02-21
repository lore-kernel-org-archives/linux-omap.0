From: Tom Rini <trini@ti.com>
Subject: Re: [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 09:08:58 -0500
Message-ID: <51262A7A.8040103@ti.com>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130221103705.GB17852@n2100.arm.linux.org.uk> <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20130221134656.GC17852@n2100.arm.linux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Joel A Fernandes <agnel.joel@gmail.com>, u-boot@lists.denx.de, Linux OMAP List <linux-omap@vger.kernel.org>, linux-kbuild@vger.kernel.org, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, tony@atomide.com, "Fernandes, Joel A" <joelagnel@ti.com>, Grant Likely <glikely@secretlab.ca>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/21/2013 08:46 AM, Russell King - ARM Linux wrote:
> On Thu, Feb 21, 2013 at 08:20:56AM -0500, Tom Rini wrote:
>> On 02/21/2013 05:37 AM, Russell King - ARM Linux wrote:
>>> On Wed, Feb 20, 2013 at 07:37:10PM -0600, Joel A Fernandes
>>> wrote:
>>>> Hello, I've been spinning some work-in-progress patches for
>>>> FIT build support in the kernel. With the move to
>>>> multiplatform support on OMAP, I feel it is a good time to
>>>> add  FIT support, also looking at the proliferating number of
>>>> dtbs, as it is a nice way
>>> 
>>> I'm not looking to add yet another crappy uboot image format to
>>> the kernel just for the hell of uboot.
>> 
>> Note that FIT images are relatively old (docs date back to March 
>> 2008).  This is more of another effort to try and update what
>> the kernel uses.
> 
> So it's five years old and people haven't been that interested in
> it so far.  That speaks volumes...

No, it was just rejected a while back over in PowerPC-land by gcl
(whom I talked with, but won't put words in his mouth here) and no one
thought about bringing it forward again until now.

>>> And don't think that the dtbs in the kernel are going to stay 
>>> there.  The longer term plan is for them to end up in an
>>> external git tree, entirely separate from the kernel source.
>>> So anything that ties them with the kernel build process will
>>> ultimately have to be removed again.
>> 
>> Well, once the device trees move to some external location, this 
>> script could also easily move out with it.  And I'd hope there'd
>> be interest out in the rest of the world for a single file boots
>> on multiple platforms image format.
> 
> We've had that for the last 18 years.  It's called zImage.  The
> real problem is that uboot has been particularly difficult over
> this - uboot and _only_ uboot wants to use its own special file
> formats.  No other boot loader on ARM has ever wanted this stuff -
> everything else has been totally happy with zImage.
> 
> uboot even now supports zImage through the bootz command, so it
> now supports the "native" format used on ARM.
> 
>> We're just about to make a lot of folks lives harder (whatever
>> the userbase is for omap2plus_defconfig).  How much time do we
>> want to spend offering up alternatives?
> 
> We're about to make it harder how?  By forcing them to use DT
> blobs? Or by forcing them to have to use the combined zImage + DT
> format because their boot loaders are soo broken that they can't
> deal with multiple images?

None of that.  We're making it harder since most folks don't have a
board with 'bootz' built-in and the 'uImage' target doesn't build now
(unless, yes, you pass LOADADDR to make) so they either format it by
hand (/ adjust their local scripting) or do what you're doing.

> Yes, things have become a _little_ harder since OMAP has switched
> to multiplatform, but it really isn't that bad.  My build and boot
> test system still works, and it uses uImage for all the OMAP
> platforms. You just have to give the right LOADADDR= argument to
> the kernel to make the uImage generation work again.  Sure, the
> resulting uImage can't be loaded at a different address, but you if
> you need to change that, you can quite easily move the existing
> uImage out and re-run make ARCH=arm uImage LOADADDR=<something
> else> and hey presto, you end up with the uImage generated for a
> different address.
> 
> But: we wouldn't be in this situation if it weren't for these
> absurd uboot uImage formats in the first place.  Or even be needing
> this FIT stuff if zImage was just used directly.

FIT isn't required.  FIT is just trying to offer a nice usability
thing to folks.  A point of device trees is a single image works in a
lot of places.  FIT gives you a single file works in a lot of places.

> uboot dug _itself_ into this hole.  It's uboot's problem.

A whole lot  of people dug this particular hole.  Joel is trying to
offer up a solution that maybe makes things easier for everyone.  Or
it gets rejected here too and distros will come up with their N
different ways to try and provide easier experiences to the end user.

- -- 
Tom
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRJip6AAoJENk4IS6UOR1W6CUP/1oxzA4MBpkC7sFlvRUE+jLk
aqF8FpsfkosN5oz1WaIAH3lV0AAUIBRLso7SfDQ+H4deCDp2zy3LZ16+jMe+hUIU
h4SReKujxR1oXUGYTYy/og6t0pN19f+KF79I6zEqfySOE4YL/BcDhqNwWTOQ2q8o
q8+w2Ez1uQTQmQu1IcQoZ7fZ41XPMfeH6zr/19oo7NC27oyiR7b230w1xiY4YIHL
Wry2tYad7XyP7lEJPanSzETWoZSS6O3uYEDKJhM98ucauJPfcVZ1GUWt4I2Q2G/3
qLKt0SVPY2kDDD6vDiCXZ8IPpxoD7Cq/tV0DRYniI9nkvoeBloZCvIQ3ZYmO/+qE
uo2Z1Pm/iRkLCLmDTOhruP6OtGepWhUvCBsSR1GoEd/sh2p93khUqwe0u6M4xr4N
aUM3Fngbjf9Mbl4gKgOHVksWIXQU0kCD09aH04YlSi1Ky5fmdO1tgHkrYoZM52WC
xMWbzez8A3OS9hb/5WhzrEhk8OOHH1l8igOdDJ2R/grDTWpSYZ7haMMghJE41fBo
ybv2QvKF6IYk1E8UsuON39uNS803AH5AwNtA1azzp/MwwYjiybxBTBoaOW4ID43R
YQ26YFNPOCvuw/ib9FkNBQrx3kt6Fu79fkyxHHDPmpxX3HVoxNDtmmm5lPymwKOu
4V0IHuD68nhvyaA1RPGp
=O7jS
-----END PGP SIGNATURE-----
