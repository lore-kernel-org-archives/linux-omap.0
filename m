From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 0/1] Fix OMAP2 NAND ONFI device detection
Date: Wed, 30 Oct 2013 20:19:57 -0300
Message-ID: <20131030231956.GA2489@localhost>
References: <1383126788-27426-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131030191414.GA16668@norris.computersforpeace.net>
 <20980858CB6D3A4BAE95CA194937D5E73EA2D41D@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47176 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751670Ab3J3XT4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Oct 2013 19:19:56 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA2D41D@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "marek.belisko@gmail.com" <marek.belisko@gmail.com>

Pekon,

Let me answer this one alone, given it's an important question.

On Wed, Oct 30, 2013 at 09:18:53PM +0000, Gupta, Pekon wrote:
> >=20
> > I'm not sure, of course, but I don't see why not. It's more likely =
to
> > break for x16 than it is for x8.
> >=20
> Another question here is ..
> The above patch assumes that user has configured GPMC bus-width
> correctly, so if user is already providing GPMC bus-width information
> via DT, then do we really need to detect NAND device bus-width again
> using NAND_BUSWIDTH_AUTO ?
>

Hm.. I think you're forgetting the original motivation for this patch,
which was initially explained by you :-) The problem is ONFI doesn't wo=
rk
in 16-bit mode.

Let me clarify. Since GPMC and NAND widths *must* match (otherwise, it
wouldn't make much sense, right?) we don't really need to autodetect th=
e
NAND width.

However, since ONFI doesn't work in 16-bit mode, we would have to do
something like this (untested pseudo code):

  nand_scan_ident(...);

  if (platform_data->devsize =3D=3D 16)
  	nand_chip->options |=3D NAND_BUSWIDTH_16;

And in some cases we might even get away with such solution. However,
we can't guarantee nand_scan_ident() doesn't need to swith to 16-bit mo=
de
inside to perform other commands (maybe some ONFI extended parameter pa=
ge).

Therefore, and given the width can be autodetected in any case (array
or ONFI based carry such information) it's much cleaner to simply do:

  nand_chip->options |=3D NAND_BUSWIDTH_AUTOMAGIC;
  nand_scan_ident(...);

See? Much cleaner, no?

And remember: the fact that we must know the device width to configure
the GPMC correctly (which being a hardware parameter belongs to the DT)
is OMAP specific. Other SoCs might not have such memory controller
and thus won't need such knowledge before hand, although that sounds
unlikely to me.

The outcome of this discussion seems to be that no driver should ever
need to specify the 'nand-bus-width' DT property, as Brian
previously suggested, right?

I must admit I'm a bit puzzled by seeing most drivers setting 16-bit
before calling nand_scan_ident(). I guess none of them relies on ONFI?
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
