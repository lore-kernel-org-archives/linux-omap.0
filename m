From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/9] OMAP2/3: Add support for flash on SDP boards
Date: Wed, 12 Aug 2009 14:30:59 +0300
Message-ID: <20090812113057.GE7278@atomide.com>
References: <20090811094348.32577.81307.stgit@localhost> <20090811095315.32577.89520.stgit@localhost> <ce9ab5790908110733g6cedd036w792ea7bc30b8e227@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62514 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbZHLLbJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 07:31:09 -0400
Content-Disposition: inline
In-Reply-To: <ce9ab5790908110733g6cedd036w792ea7bc30b8e227@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimal.newwork@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* vimal singh <vimal.newwork@gmail.com> [090811 17:34]:
> On Tue, Aug 11, 2009 at 3:23 PM, Tony Lindgren<tony@atomide.com> wrot=
e:
> > Add support for flash on SDP boards. Currently only onenand
> > is supported.
> >
> > Only tested on 3430SDP, somebody please test on 2430SDP and
> > check the chip select for 2430SDP.
> >
> > Also note that in the earlier 2430SDP code the kernel partition
> > was set to only 1MB instead of 2MB on 3430SDP. If people want
> > the old partition sizes back on 2430SDP, please provide a patch.
> >

<snip>

> > +static struct omap_onenand_platform_data board_onenand_data =3D {
> > + =A0 =A0 =A0 .cs =A0 =A0 =A0 =A0 =A0 =A0 =3D 2, =A0 =A0/* REVISIT:=
 Is this the same for 2430 SDP? */
>=20
> SDP3430 V2 Board CS organization is different from SDP3430 V1. Now 4
> dip switches are used to specify CS configuration for flashes.

Hmm, OK thanks. That could be done with a cmdline option, or
by adding the GPMC probing in some generic form on top of this patch.

Do you still want this patch to get integrated, or me to drop it
until somebody patches support for toggling the chip select?

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
