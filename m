From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/2] arm: omap: ehci: avoid compiler error with
 touchbook
Date: Tue, 9 Mar 2010 17:47:55 +0200
Message-ID: <20100309154754.GI3851@gandalf>
References: <20100304074434.GI15954@nokia.com>
 <1267688753-6344-1-git-send-email-felipe.balbi@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0321CBCDFE@dbde02.ent.ti.com>
 <a05a09f453a7473f2ba54a9056589b72@secure211.sgcpanel.com>
 <20100305070330.GB12757@nokia.com>
 <20100308230422.GH2900@atomide.com>
 <20100309143020.GA12260@gandalf>
 <20100309153827.GR2900@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52113 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab0CIPrn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 10:47:43 -0500
Content-Disposition: inline
In-Reply-To: <20100309153827.GR2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, Felipe Balbi <felipe.balbi@nokia.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Tue, Mar 09, 2010 at 07:38:27AM -0800, Tony Lindgren wrote:
> But sounds like your fix to mark anything going to init.rodata as const
> is correct since it is rodata. I was originally thinking this is somehow
> related to __init vs __initconst, but it's for __initconst only, and
> we should use const there as it's read only.
> 
> Let me take another look at your patches and make sure everything
> compiles OK, I don't think we're using __initconst in that many places.

the problem is when you put const and non-const variables inside
.init.rodata section. gcc manual might have something about that.

-- 
balbi
