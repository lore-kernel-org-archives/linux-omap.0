From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v1 0/2] mtd: nand: omap: booting from NAND using u-boot
Date: Sat, 25 Jan 2014 00:55:37 -0800
Message-ID: <20140125085537.GA3162@norris-Latitude-E6410>
References: <1386925978-23705-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:42574 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbaAYIzs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Jan 2014 03:55:48 -0500
Received: by mail-pa0-f47.google.com with SMTP id kp14so4127065pab.6
        for <linux-omap@vger.kernel.org>; Sat, 25 Jan 2014 00:55:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386925978-23705-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>, Scott Wood <scottwood@freescale.com>, Tom Rini <trini@ti.com>, u-boot@lists.denx.de, linux-mtd@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>, Enric Balletbo Serra <eballetbo@iseebcn.com>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Igor Grinberg <grinberg@compulab.co.il>, Michael Trimarchi <michael@amarulasolutions.com>, r.meier@siemens.com, r-woodruff2@ti.com, Nikita Kiryanov <nikita@compulab.co.il>, jp.francois@cynove.com, ivan.djelic@parrot.com, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, avinashphilipk@gmail.com, balbi@ti.com

Hi Pekon,

Sorry, I'm revisiting your patch series a bit late. There are a few
factors that contributed to this, though.

1. This patch series talks extensively about U-Boot. U-Boot is not my
   interest, nor should it be the focus of kernel (driver) development.
   Any work done here should be framed in the kernel driver context. [1]

2. You have previously CC'd me on U-Boot patches. Or at least, I think
   so. More about this in the next point...

3. The U-Boot source code structure is rather similar to pieces of Linux
   subsystems. So without additional effort, it is hard to discern
   whether a patch is intended for Linux MTD or U-Boot MTD.

4. You cross-posted to both the U-Boot and Linux-MTD mailing lists.

So the sum of all this is that I ignored these patches at first, as they
weren't clearly intended for me.

On Fri, Dec 13, 2013 at 02:42:56PM +0530, Pekon Gupta wrote:
> As there were parallel set of patches running between u-boot and kernel.

I don't know what patches you're talking about.

> hence, some patch-sets caused regression for OMAP3x platforms when booting

"Hence" is not the right word. The previous sentence doesn't imply that
there were regressions.

> using u-boot specifically for ecc-schemes (like BCH4_SW).

Huh? What does "specifically for ecc-schemes" mean? You mean that only
some schemes had regressions? Can you be more specific? What are these
regressions?

The rest of this cover letter (and most of the patch descriptions)
describes the configurations and testing (which is all very good, don't
get me wrong), with a lot of focus on things I don't follow (namely,
U-Boot), but you omit many of the important details, like

 * What is the regression? I honestly don't see a description of the
   actual regression. (I can read the code to intuit that, but what's
   the point of your pages of description if it doesn't mention this?)
   Please give some logical description of the problem
 * What are the effects of the regression? ECC bytes in the wrong place,
   so you see correction failures/corruption? JFFS2 failures? (The
   "oobfree" changes, for instance, should only affect something like
   JFFS2.)
 * What Linux commit caused the regression?
 * Should this patch set be marked for -stable? And for what kernel
   release? (the previous question would help answer this)

> Hence this patch series fixes those regressions, and tests complete
[...] snip

I'm preparing a 3.14 pull request soon, and since you seem committed to
fixing and properly testing a known regression here, I'd like to see
this go in. But given the late timing and the unanswered questions, I
think it's unlikely to go in -rc1. Perhaps I can send a later pull
request if we can get it together properly.

So I'd like to first of all get a few answers to my questions, and then
I think we might want to refresh this patch series with a little better
commit messages and perhaps a separate documentation file (not
necessarily in the same patch series, as the fix is more urgent).

Brian

   [1] For instance, rather than saying "the ECC layout doesn't match
   U-Boot", you should probably describe what the intended ECC layout
   should look like and show that Linux does not match it. Perhaps it's
   time for some better documentation, like Ezequiel stashed under
   Documentation/mtd/nand/ for pxa3xx. You could also take some cues
   from Huang's comments on ECC layouts, etc., in gpmi-nand.c.
