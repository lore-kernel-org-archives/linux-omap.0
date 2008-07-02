From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Suggestion required to switch to a new kernel
Date: Thu, 3 Jul 2008 01:28:45 +0300
Message-ID: <20080702222830.GD13834@frodo>
References: <20080702140237.qt1dx5beo70g8048@webmail.mistralsolutions.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40857 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756397AbYGBW25 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2008 18:28:57 -0400
Content-Disposition: inline
In-Reply-To: <20080702140237.qt1dx5beo70g8048@webmail.mistralsolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: suresh@mistralsolutions.com
Cc: linux-omap@vger.kernel.org

On Wed, Jul 02, 2008 at 02:02:37PM -0500, suresh@mistralsolutions.com wrote:
> We are working on a product which is based on OMAP5912 (OSK). As of now, 
> we are using linux-omap 2.6.16-rc3.
>
> We had issues with the JFFS2 cleanmarkers on oneNAND. JFFS2 driver in  
> 2.6.16-rc3 did not understand the segmented OOB in oneNAND. Rather than  
> trying to backport the driver fixes, we have decided to upgrade to a new 
> kernel which includes that fix (We noticed that it was fixed in  2.6.21).
>
> We would really appreciate suggestions from people on the list about the 
> kernel version that would be the best to switch to. We want to know which 
> kernel version is stable on OMAP. Some of our requirements are;
>
> 1. DSP gateway should work on that kernel without any issues.
> 2. Power management should be functional. Our product uses power  
> management to a great extent.
>
> We are thinking of 2.6.24 (or 2.6.23). Please let us know your suggestions.

Using current kernel versions is always a good idea. 2.6.24 should be
good for osk, but testing is always good.

Use the defconfig and change some options here and there and try it out.
Report here if you find any issues :-)

--
	- Balbi
