From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 1/3] Add support for OMAP35x processors
Date: Sun, 11 Jan 2009 23:45:37 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301BB858BCD@dbde02.ent.ti.com>
References: <1231617637-18704-1-git-send-email-premi@ti.com>
 <20090110221618.GI25493@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51201 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbZAKSQm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Jan 2009 13:16:42 -0500
In-Reply-To: <20090110221618.GI25493@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com] 
> Sent: Sunday, January 11, 2009 3:46 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/3] Add support for OMAP35x processors
> 
> On Sun, Jan 11, 2009 at 01:30:37AM +0530, Sanjeev Premi wrote:
> > +config MACH_OMAP_LDP
> > +	bool "OMAP3 LDP board"
> > +	depends on ARCH_OMAP3 && ARCH_OMAP34XX && !ARCH_OMAP35XX
> > +
> >  config MACH_OMAP_3430SDP
> >  	bool "OMAP 3430 SDP board"
> > -	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > +	depends on ARCH_OMAP3 && ARCH_OMAP34XX && !ARCH_OMAP35XX
> 
> This will prevent that we build a kernel for both 3430sdp and 
> any 35xx-based board, right ?

Yes. But 3430SDP will not have any of 35xx processors; changes may seem minor but may play difficult someday.

> 
> >  
> >  config MACH_OMAP3EVM
> >  	bool "OMAP 3530 EVM board"
> > -	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > +	depends on ARCH_OMAP35XX
> 
> why removed ARCH_OMAP3 ??

Not really removed; I felt it was duplicated as choosing ARCH_OMAP3 does an automatic "select" fir ARCH_OMAP3. see:

+config ARCH_OMAP35XX
+	bool "OMAP35x Family"
+	select ARCH_OMAP3
+	select ARCH_OMAP34XX
+	select ARCH_OMAP3430
+	select NEON
+	help

> 
> --
> balbi
> 
> 