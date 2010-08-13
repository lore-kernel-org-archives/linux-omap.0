From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: omap3630: cpu revision bits are different
Date: Fri, 13 Aug 2010 13:24:08 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E81475D0@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E81471BE@dbde02.ent.ti.com>
 <20100813062255.GA12706@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55790 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755024Ab0HMHyQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 03:54:16 -0400
In-Reply-To: <20100813062255.GA12706@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Friday, August 13, 2010 11:53 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: omap3630: cpu revision bits are different
> 
> * Premi, Sanjeev <premi@ti.com> [100812 15:42]:
> > Hi all,
> > 
> > While re working on the cpu revision patch, I came
> > across these definitions:
> > 
> > #define OMAP3630_REV_ES1_0      0x36300034
> > #define OMAP3630_REV_ES1_1      0x36300134
> > #define OMAP3630_REV_ES1_2      0x36300234
> > 
> > Contrast this with:
> > 
> > #define OMAP3430_REV_ES1_0      0x34300034
> > #define OMAP3430_REV_ES2_0      0x34301034
> > #define OMAP3430_REV_ES2_1      0x34302034
> > 
> > I may have missed the discussion on this list, but
> > wanted to quickly check if the difference in intended
> > OR accidental.
> 
> Hmm for those defines it should be just a running
> number for the revision so we should most likely
> just renumber the OMAP3430_REV_ES bits.
>  
> > I do recognize that definitions for 3630 start at lower
> > nibble, so they appear to be better choice.
> 
> Yeah. Care to do a patch to renumber 3430 revision
> bits for the next merge window? AFAIK, that should
> change anything in the functionality so it's only
> a cosmetic change. Should be grepped carefully though :)

Will do so... will have it ready by MON.

> 
> Tony
> 