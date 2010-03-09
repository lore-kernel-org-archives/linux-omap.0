From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/2] arm: omap: ehci: avoid compiler error with
 touchbook
Date: Tue, 9 Mar 2010 16:30:20 +0200
Message-ID: <20100309143020.GA12260@gandalf>
References: <20100304074434.GI15954@nokia.com>
 <1267688753-6344-1-git-send-email-felipe.balbi@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0321CBCDFE@dbde02.ent.ti.com>
 <a05a09f453a7473f2ba54a9056589b72@secure211.sgcpanel.com>
 <20100305070330.GB12757@nokia.com>
 <20100308230422.GH2900@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59486 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657Ab0CIOaP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 09:30:15 -0500
Content-Disposition: inline
In-Reply-To: <20100308230422.GH2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "ext me@felipebalbi.com" <me@felipebalbi.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

On Mon, Mar 08, 2010 at 03:04:23PM -0800, Tony Lindgren wrote:
> Hmm yeah thanks for digging into this mystery. Looks like we're
> hitting some Linux initdata limitation.
> 
> We can't mark everything as __initconst. Some platform data can
> get dynamically set based on the board type for resources.
> 
> So to me it sounds like the only solution is to mark everything
> as __initdata and ignore the (correct) const for now for __initdata.
> 
> Or am I missing something?

sure. I'll cook something. But then it means all ehci_hcd_platform_data
won't be able to be declared as const or that might cause problems as
well later.

-- 
balbi

