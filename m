From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap3630: cpu revision bits are different
Date: Fri, 13 Aug 2010 09:22:57 +0300
Message-ID: <20100813062255.GA12706@atomide.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E81471BE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62596 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab0HMGXG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 02:23:06 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E81471BE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Premi, Sanjeev <premi@ti.com> [100812 15:42]:
> Hi all,
> 
> While re working on the cpu revision patch, I came
> across these definitions:
> 
> #define OMAP3630_REV_ES1_0      0x36300034
> #define OMAP3630_REV_ES1_1      0x36300134
> #define OMAP3630_REV_ES1_2      0x36300234
> 
> Contrast this with:
> 
> #define OMAP3430_REV_ES1_0      0x34300034
> #define OMAP3430_REV_ES2_0      0x34301034
> #define OMAP3430_REV_ES2_1      0x34302034
> 
> I may have missed the discussion on this list, but
> wanted to quickly check if the difference in intended
> OR accidental.

Hmm for those defines it should be just a running
number for the revision so we should most likely
just renumber the OMAP3430_REV_ES bits.
 
> I do recognize that definitions for 3630 start at lower
> nibble, so they appear to be better choice.

Yeah. Care to do a patch to renumber 3430 revision
bits for the next merge window? AFAIK, that should
change anything in the functionality so it's only
a cosmetic change. Should be grepped carefully though :)

Tony
