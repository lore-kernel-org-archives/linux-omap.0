From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2 01/10] OMAP: mach-omap2: Fix incorrect assignment
 warnings
Date: Mon, 11 Oct 2010 09:21:13 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBABBC38@dbde02.ent.ti.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
	<1285063280-4057-2-git-send-email-manjugk@ti.com>
 <878w28v3xx.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48257 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121Ab0JKDvW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Oct 2010 23:51:22 -0400
In-Reply-To: <878w28v3xx.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "Menon, Nishanth" <nm@ti.com>

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Saturday, October 09, 2010 1:43 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Tony Lindgren; Menon, Nishanth
> Subject: Re: [PATCH v2 01/10] OMAP: mach-omap2: Fix incorrect 
> assignment warnings
> 
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> > This patch fixes below sparse warnings for incorrect assignments.
> 
> As pointed out by Jean, this patch fixed some sparse 
> warnings, but also broke some things, specifically off mode.
> 
> In the future, *please* be sure to test the code paths that 
> are being changed.  This patch changed some code that is only 
> exercised during off-mode, but was clearly not tested with 
> off mode enabled.
> 
> As background for why this broke functionality, keep this in mind:
> 
>  	void *a = NULL;
> 	u32 *b = NULL;
> 
> a + 1 = 1
> b + 1 = 4
> 
> IOW, you cannot simply replace a 'u32 *' by a 'void *' 
> without checking and fixing any pointer arithmetic.

I apologize for breaking off mode support. Since sparse fixes is big patch
series, I was able to test only boot and same was mentioned along with
the test report in the series. Also, multiple versions of patches posted
for review, I was expecting comments on this type of regressions.

I will take care of testing code coverage paths for future patches.

Thanks to Jean and Kevin for identifying and fixing this regression.

-Manjunath