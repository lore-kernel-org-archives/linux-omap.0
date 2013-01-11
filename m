From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: McBSP functions not exported
Date: Fri, 11 Jan 2013 14:17:03 +0100
Message-ID: <50F010CF.8020808@ti.com>
References: <20130111114846.00005679@unknown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50270 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754977Ab3AKNRQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Jan 2013 08:17:16 -0500
In-Reply-To: <20130111114846.00005679@unknown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Barker <paul@paulbarker.me.uk>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

Hi,

On 01/11/2013 12:48 PM, Paul Barker wrote:
> Hi,
>=20
> I'm currently working on a driver to talk to an analog-to-digital
> converter (specifically a Texas Instruments ADS1672) connected to the
> McBSP port on a Beagleboard-xM. I'm currently building my driver modu=
le
> against a 3.2 series kernel with Beagleboard patches and config from
> https://github.com/beagleboard/kernel (branch beagleboard-3.2). I'd
> like to keep up-to-date with the more recent kernels but my module
> won't compile with them.
>=20
> When the OMAP McBSP driver stack was merged into a single driver
> (commit 45656b4 by Peter Ujfalusi, looks like it went into linux 3.3)
> all the EXPORT_SYMBOL macros were removed so I can no longer call the
> functions I was using from my external module. Alternatively I could
> just be missing something really obvious, let me know if I am!

Since 3.3 there were even more changes in the McBSP driver stack. We (I=
) did
removed lot's of code and it is more focused on it's main functionality=
 (ASoC).
What functions you were using from the McBSP driver(s)?

> I'm just wondering what the best way forward is from here and I'm sur=
e
> I can't be the only person who was using the McBSP driver code in the
> kernel to interface with external hardware. The two options I can thi=
nk
> of are either that I move my driver into the kernel source tree itsel=
f
> or the McBSP driver functions are exported again so that they can be
> used by external modules. It's easier to maintain an external module
> than a series of patches against the kernel, unless a driver for an
> analog-to-digital converter connected to the McBSP port is something
> that would actually have a chance of being merged into the mainline
> kernel. I could look at making this driver more generic once I have t=
he
> current hardware/driver combination working, so that it should work
> with most analog-to-digital converters - I haven't found such a drive=
r
> in my previous googling.

I have taken a brief look at ADS1672 datasheet. At first glance I would=
 think
that if you connect the ADC to SPI port of OMAP3 you should be able to =
read
the data out as well. On BeagleBoard-xM you should have access to McSPI=
3 (CS0,
CS1) and McSPI4 (CS0).

> If you have any advice on this or a pointer to a better place to ask
> this question please let me know.

Can you try to see if you can use McSPI for your application?

As background: we did not had any other uses of McBSP when I have decid=
ed to
merge the code and move it out from arch/arm/plat-omap/ This was needed=
 to be
done in any ways. The decision back then was that since we don't have u=
sers
for McBSP other than audio, it is going to be moved under sound/soc/oma=
p/

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
