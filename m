From: Tom Rini <trini@ti.com>
Subject: Re: [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 08:29:34 -0500
Message-ID: <5126213E.9010809@ti.com>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <5125A1FE.5000604@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <5125A1FE.5000604@wwwdotorg.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Joel A Fernandes <agnel.joel@gmail.com>, u-boot@lists.denx.de, Linux OMAP List <linux-omap@vger.kernel.org>, linux-kbuild@vger.kernel.org, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, tony@atomide.com, "Fernandes, Joel A" <joelagnel@ti.com>, Grant Likely <glikely@secretlab.ca>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/20/2013 11:26 PM, Stephen Warren wrote:
> On 02/20/2013 06:37 PM, Joel A Fernandes wrote:
>> Hello, I've been spinning some work-in-progress patches for FIT
>> build support in the kernel. With the move to multiplatform
>> support on OMAP, I feel it is a good time to add  FIT support,
>> also looking at the proliferating number of dtbs, as it is a nice
>> way
> 
> To my mind, FIT is pointless. And forcing the kernel build process
> to create bootloader-specific files doesn't seem like a good idea.
> Doing so would require pulling in even more outside tools into the
> kernel build flow.

No, it requires no more tools than we have today.  It's still just
mkimage and a device tree file.

> All you need is to copy the zImage and any relevant .dtb files
> into /boot, and have U-Boot load the relevant .dtb file by
> constructing the filename as roughly ${soc}-${board}.dtb, then use
> the bootz command to boot it. You can have a completely generic
> boot.scr (or built-in script).

Note you still have to copy N dtb files into the filesystem.  Or one
file, the FIT image.

> Note: Not all (many?) U-Boot support FIT anyway, so you'd need to
> flash a new U-Boot to support FIT, so you may as well just flash a
> new U-Boot that implements the ${soc} and ${board} variables
> instead. IIRC, there may also be a ${boardname} or similar that's
> like ${board}, but represents the runtime-detected board for when
> one U-Boot build actually supports multiple different boards.

And enable bootz as well.  Just about as many boards enable that as do
FIT.  And FIT has been around for years, bootz not so.  So in theory
folks with old/odd boards that didn't bother to get mainlined in
U-Boot could still have FIT support added, easily.

- -- 
Tom
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRJiE9AAoJENk4IS6UOR1WmVsP/2FEIJVDkB1Aefl5Zs0c1pGa
FjhDKASnsu8SqjHfjP6o0xkbxhdQHQw0AzDGOlGfbkDk7SUVLmyYkI8WeeZ/O6dB
cGW7zTV1TXU+Hjl3VqDBID7cskCANNn35fcbba5Q9+0Lo+KD39Jme63hilu2EBfj
njFbC55+U4yOY+uRD99w32GMd+yHaOL5yTQICmMasBuwsRfP/vrPIy9LBQ7z73Xd
f9/D0tfz1O5/QHxkn41zHfHDKoTpa3fbDcp3d/jgPPQK682nN38RD48s4AeC/1m4
GsnHEY3ykMIAPV49dEBm3ebC0HavIZ5sB5JlQh09Hk7kPQ4yJJgwpLzhxhByN0LR
3s5OgexNAuREtJWbOpghwS2d2GajNSPy845TmznkZI9gTWUi5PhA/6h+JQVm7/Ls
K515cs4TSvAEHUMP60AtvSi8Axe6nnDAJcTpPEeQyskCR2jGAmt80XsioJ0fprls
cZZr7shkarqdQbFjSLpvIFVSo0//xPq4OaLqoKInxmDQEYNmzCcKsbB2LlXywq7l
Tr6vrxe9O2BhJhXpi1NNBlJsOmII3Ft6/0MKKer8E3poITo6TKbRQG2O17lR49JP
RRbIKDB8X1wM2YybHHQaGwOTnkjZSGsYHDi9qKuK27UA27qGbu/FDmfHYPHsNpBo
ziTmDL5uI7rFQEkHiYVd
=M25C
-----END PGP SIGNATURE-----
