From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP4: Keyboard: Mux changes in the board file
Date: Mon, 11 Jul 2011 13:08:03 -0700
Message-ID: <1310414883.3077.101.camel@vence>
References: <1308831317-17092-1-git-send-email-shubhrajyoti@ti.com>
	 <20110701074824.GH23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:39794 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752346Ab1GKUII (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 16:08:08 -0400
Received: by mail-yx0-f171.google.com with SMTP id 38so1820704yxk.30
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 13:08:07 -0700 (PDT)
In-Reply-To: <20110701074824.GH23145@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org

On Fri, 2011-07-01 at 00:48 -0700, Tony Lindgren wrote:
> * Shubhrajyoti D <shubhrajyoti@ti.com> [110623 05:10]:
> > The mux settings for keypad  are done for omap4430sdp in
> > board file.
> 
> Applying into devel-board branch.
> 
> > +static struct omap_board_data keypad_data = {
> > +	.id	    = 1,
> > +	.pads	 = keypad_pads,
> > +	.pads_cnt       = ARRAY_SIZE(keypad_pads),
> > +};
> 
> Aligned this struct better.

This patch (and this struct) introduces another section mismatch warning
because it references another struct which is __initdata but the struct
itself is not:

WARNING: vmlinux.o(.data+0x37788): Section mismatch in reference from
the variable keypad_data to the (unknown reference) .init.data:(unknown)
The variable keypad_data references
the (unknown reference) __initdata (unknown)

A quick glance suggests the the right fix is that this struct should
also be __initdata:

diff --git a/arch/arm/mach-omap2/board-4430sdp.c
b/arch/arm/mach-omap2/board-4430sdp.c
index c7cef44..66758bf 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -199,7 +199,7 @@ static struct omap4_keypad_platform_data
sdp4430_keypad_data = {
 	.cols			= 8,
 };
 
-static struct omap_board_data keypad_data = {
+static struct omap_board_data keypad_data __initdata = {
 	.id	    		= 1,
 	.pads	 		= keypad_pads,
 	.pads_cnt       	= ARRAY_SIZE(keypad_pads),


