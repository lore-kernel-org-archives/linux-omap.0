From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: OMAP4+: Move SRAM data to DT
Date: Tue, 03 Sep 2013 16:35:19 +0200
Message-ID: <1378218919.5891.3.camel@weser.hi.pengutronix.de>
References: <1377598305-15539-1-git-send-email-rnayak@ti.com>
	 <1377598305-15539-3-git-send-email-rnayak@ti.com>
	 <CA+Bv8XaK3fBkRZjN8dCzi9dt9C3SVe2nT746Szzb_F=69w=fMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52005 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344Ab3ICOix (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Sep 2013 10:38:53 -0400
In-Reply-To: <CA+Bv8XaK3fBkRZjN8dCzi9dt9C3SVe2nT746Szzb_F=69w=fMw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, bcousson@baylibre.com

Am Dienstag, den 03.09.2013, 06:56 -0700 schrieb Russ Dill:
> On Tue, Aug 27, 2013 at 3:11 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> > Use drivers/misc/sram.c driver to manage SRAM on all DT only
> > OMAP platforms (am33xx, am43xx, omap4 and omap5) instead of
> > the existing private implementation.
> >
> > Address and size related data  is removed from mach-omap2/sram.c
> > and now passed to drivers/misc/sram.c from DT.
> >
> > Users can hence use general purpose allocator apis instead of
> > OMAP private ones to manage and use SRAM.
> >
> > Currently there are no users on SRAM on these platfoms.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> 
> I was trying to experiment with this on am33xx, but I noticed that the
> ioremap region is not marked exec, so it cannot be used to run code.

Could you outline a use-case where you would need to execute code from
SRAM while running in a linux system? I'm curious what you would use
this for.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

