From: David Brownell <david-b@pacbell.net>
Subject: Re: omap3evm mmc problem
Date: Wed, 25 Mar 2009 13:28:46 -0700
Message-ID: <200903251328.46683.david-b@pacbell.net>
References: <gq1s6e$ssu$1@ger.gmane.org> <200903251040.36300.david-b@pacbell.net> <49CA9156.6080805@telus.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n30.bullet.mail.mud.yahoo.com ([68.142.207.49]:30118 "HELO
	n30.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757481AbZCYU2u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Mar 2009 16:28:50 -0400
In-Reply-To: <49CA9156.6080805@telus.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dfoley <dfoley@telus.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Wednesday 25 March 2009, dfoley wrote:
> 
> SD seems to work now with patch below and REGULATOR_TWL4030 [=y].
> For the patch, I just copied from other boards in mach-omap2, so
> I really have no idea if it's correct.

I think you don't need to set up VSIM, since that board
only seems to support 4-wire SD cards (not 8-wire MMCplus).
Else mmc[0].wires == 4 would be wrong...


