From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] i2c-omap: Make sure i2c bus is free before setting it
 to idle
Date: Thu, 16 Sep 2010 15:40:50 -0700
Message-ID: <20100916224050.GU29610@atomide.com>
References: <1282808204-1689-1-git-send-email-mathias.nyman@nokia.com>
 <20100826074118.GH23263@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65484 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998Ab0IPWky (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 18:40:54 -0400
Content-Disposition: inline
In-Reply-To: <20100826074118.GH23263@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "Nyman Mathias (Nokia-MS/Helsinki)" <Mathias.Nyman@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-i2c@vger.kernel.org, ben-linux@fluff.org

* Felipe Balbi <felipe.balbi@nokia.com> [100826 00:34]:
> Hi,
> 
> On Thu, Aug 26, 2010 at 09:36:44AM +0200, Nyman Mathias (Nokia-MS/Helsinki) wrote:
> >If the i2c bus receives an interrupt with both BB (bus busy) and
> >ARDY (register access ready) statuses set during the tranfer of the last message
> >the bus was put to idle while still busy.
> >
> >This caused bus to timeout.
> >
> >Signed-off-by: Mathias Nyman <mathias.nyman@nokia.com>
> 
> adding linux-i2c and Ben Dooks to Cc list.

Ben, can you please take this? The patchwork.kernel.org link is:

http://patchwork.kernel.org/patch/133641/

Or let Mathias know if he should repost.

Acked-by: Tony Lindgren <tony@atomide.com>
 
> >---
> >drivers/i2c/busses/i2c-omap.c |    2 ++
> >1 files changed, 2 insertions(+), 0 deletions(-)
> >
> >diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> >index 824ac1c..3271ce1 100644
> >--- a/drivers/i2c/busses/i2c-omap.c
> >+++ b/drivers/i2c/busses/i2c-omap.c
> >@@ -602,6 +602,8 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> >
> >	if (r == 0)
> >		r = num;
> >+
> >+	omap_i2c_wait_for_bb(dev);
> >out:
> >	omap_i2c_idle(dev);
> >	return r;
> >-- 
> >1.5.6.5
> >
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> balbi
> 
> DefectiveByDesign.org
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
