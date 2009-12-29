From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: L4 interconnect memory mapping
Date: Wed, 30 Dec 2009 01:28:19 +0200
Message-ID: <1262129299.28789.97.camel@gandalf>
References: <1262129134.28789.96.camel@gandalf>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:37945 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbZL2X2X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 18:28:23 -0500
In-Reply-To: <1262129134.28789.96.camel@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: paul@pwsan.com, linux-omap@vger.kernel.org

Hi,

On Wed, 2009-12-30 at 01:25 +0200, Felipe Balbi wrote:
> Hi Tony and Paul,
> 
> maybe a silly question, but here it goes:
> 
> Do we have any piece of code handling the L4 interconnect memory space ?
> I mean, looking at omap3 TRM pages 212 - 219, I see that e.g. for the
> musb block we have:
> 
> HS USB OTG	0x480AB000 - 0x480ABFFF	4KB	Module
> 		0x480AC000 - 0x480ACFFF	4KB	L4 interconnect
> 
> So the first 4K is what we pass down to drivers via struct resource and
> the second 4K ? What do we do with that ?

no with Paul's address correct.

-- 
balbi

