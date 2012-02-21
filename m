From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] tty: serial: OMAP: block idle while the UART is
 transferring data in PIO mode
Date: Tue, 21 Feb 2012 15:02:07 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202211456160.25023@utopia.booyaka.com>
References: <20120126024903.31613.24730.stgit@dusk> <20120126025036.31613.67819.stgit@dusk> <4F423E28.3040404@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1274065210-1329861727=:25023"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39093 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755602Ab2BUWCI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Feb 2012 17:02:08 -0500
In-Reply-To: <4F423E28.3040404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1274065210-1329861727=:25023
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Salut Beno=EEt,

On Mon, 20 Feb 2012, Cousson, Benoit wrote:

> 3.3-rc4 is broken in the DT case because of the serial driver. And it=20
> looks like it is due to this fix.  We cannot rely on pdata anymore in=20
> DT, and in that case it leads to an Oops due to NULL pdata.

Sorry about the breakage.  I agree with the diagnosis.  That code was just=
=20
copied from the DMA errata part of the driver, so it will need to be fixed=
=20
as well.  Otherwise the same problem will happen when DMA is enabled.

> And then we will have to add the support for all these OMAP custom hooks =
without pdata.

That's really the key question for the medium- to long-term...

> A basic fix (below) for the moment is to test for valid pdata inside the =
driver.
> I'll repost it properly if you are fine with it.

Looks fine to me, although I'd suggest fixing the DMA workaround path as=20
well.

Reviewed-by: Paul Walmsley <paul@pwsan.com>


- Paul
--155748971-1274065210-1329861727=:25023--
