From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix omapfb's problem on OMAP3430sdp
Date: Wed, 03 Sep 2008 09:53:16 +0800
Message-ID: <1220406796.7042.34.camel@localhost>
References: <1220276228.2680.9.camel@localhost>
	 <200809020751.48357.david-b@pacbell.net>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:58322 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbYICBvf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Sep 2008 21:51:35 -0400
In-Reply-To: <200809020751.48357.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Tue, 2008-09-02 at 07:51 -0700, David Brownell wrote:
> On Monday 01 September 2008, stanley.miao wrote:
> > +       if(!is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
> 
> But checkpatch.pl rejected that, yes?  Fixed in a later
> version I see.

It has been fixed in a later version.
> 
> ... and in "static int sdp2430_panel_enable(...)" this would
> seem to be wrong.  But for that matter, lcd_2430sdp.c should
> not be relevant for any 3430 board anyway...

this was shared between two boards.

> 
> If that file is, oddly, being shared between two boards ...
> then put that code in the "if (machine_is_omap_3430sdp())"
> block.  And someone should consider renaming the file if
> it's not specific to the 2430 SDP.

OMAP3430_ES1 doesn't have this problem.

Stanley.

> 
> 
> 
