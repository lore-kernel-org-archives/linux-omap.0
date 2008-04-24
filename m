From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/5] Updates on mcbsp driver
Date: Fri, 25 Apr 2008 00:10:20 +0300
Message-ID: <20080424211019.GC8794@kedavra.cpe.vivax.com.br>
References: <1209052465-13210-1-git-send-email-edubezval@gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55050 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbYDXVIw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 17:08:52 -0400
Content-Disposition: inline
In-Reply-To: <1209052465-13210-1-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

On Thu, Apr 24, 2008 at 11:54:20AM -0400, Eduardo Valentin wrote:
> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> 
> This patch series updates mcbsp driver by transforming it into
> a platform driver. This is a very initial implementation.
> Basically it moves machine specific code to their correct place
> and creates the platform driver necessary structures.
> 
> It must be working for previous boards. For omap34xx it should
> work for mcbsp 1 and 2.
> 
> In order to do not break other places, I tryied to do not change
> previous API. But future improvements are needed.
> 
> Clock definitions for  mcbsp 1 and 2 were also modified to add
> correct support for omap34xx.
> 
> Comments are wellcome.

checkpatch doesn't complain, although i didn't really test it.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
