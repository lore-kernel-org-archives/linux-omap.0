From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: Ethernet problems on AM3517, possible regression?
Date: Tue, 06 Mar 2012 11:16:56 +0200
Message-ID: <4F55D608.3040706@compulab.co.il>
References: <1330488712.31452.YahooMailNeo@web125205.mail.ne1.yahoo.com> <1330536469.53752.YahooMailNeo@web125203.mail.ne1.yahoo.com> <1330621988.48456.YahooMailNeo@web125202.mail.ne1.yahoo.com> <1330643793.82609.YahooMailNeo@web125204.mail.ne1.yahoo.com> <1330968742.99498.YahooMailNeo@web125205.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:54716
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754756Ab2CFJRE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 04:17:04 -0500
In-Reply-To: <1330968742.99498.YahooMailNeo@web125205.mail.ne1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: CF Adad <cfadad@rocketmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On 03/05/12 19:32, CF Adad wrote:
> Hi Igor,
> 
> 
> Thanks for your reply!  So are both ports working on the CM-T3517 simultaneously now?

Well, you need to apply all the patches I've sent you.

>  Looking at the latest board file for the CM-T3517 (arch/arm/mach-omap2/board-cm-t3517.c), I don't see either the SMSC or the EMAC ports being initialized.  Has that initialization code been moved somewhere else in the kernel?
> 

Again, you need to apply the patches I've sent you.

> Regarding the patches:  I had actually seen those (in the previous "version #2" I believe), and applied them to our kernel.

v3 is slightly different and you need the patch for the board file.
You need also the patches I've sent you privately.

>  If you take a look at my board file below, you'll notice I defined a "USE_ALT__EMAC_ETH" definition that causes the separate EMAC file (created by those patches) to be used.  I've tried both the old and the new (separate file) way of doing this.  Our EMAC does work fine, as does our SMSC, except our SMSC does not store a MAC address.  They just do not work together.  One or the other must be disabled (commented out of the code) or neither work.

The patch I've sent you solves exactly that...

> 
> It appears to me that the problem with running both is the mdio id setting.  Perhaps they're both demanding the same slot or something?

Yes, there were several changes made to MDIO framework and how the whole thing is handled.


-- 
Regards,
Igor.
