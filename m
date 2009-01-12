From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH v2] OMAP: Fix McBSP spin_lock deadlock.
Date: Mon, 12 Jan 2009 18:42:38 +0800
Message-ID: <1231756958.24932.4.camel@localhost>
References: <1225975475-9300-1-git-send-email-stanley.miao@windriver.com>
	 <1226065961.24669.8.camel@localhost>  <20090108133356.GI27566@atomide.com>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:42145 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271AbZALKeI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Jan 2009 05:34:08 -0500
In-Reply-To: <20090108133356.GI27566@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thu, 2009-01-08 at 15:33 +0200, Tony Lindgren wrote:
> * stanley.miao <stanley.miao@windriver.com> [081107 15:47]:
> > This solution keeps the virtual clock in place and enable the child
> > clocks before enable the virtual clock. So, any comments ?
> 
> What if we just removed the custom clock and had a struct **clk
> in struct omap_mcbsp that contains the clocks for each instance?

It works. This is what I did in my first patch. 

The difference is I add two struct *clk in struct omap_mcbsp.

struct omap_mcbsp {
@@ -365,7 +366,8 @@ struct omap_mcbsp {
        /* Protect the field .free, while checking if the mcbsp is in
use */
        spinlock_t lock;
        struct omap_mcbsp_platform_data *pdata;
-       struct clk *clk;
+       struct clk *ick;
+       struct clk *fck;


If one struct **clk is better, I will resend the patch later.

Stanley
