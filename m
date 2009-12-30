From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: L4 interconnect memory mapping
Date: Wed, 30 Dec 2009 13:56:29 +0200
Message-ID: <1262174189.28789.181.camel@gandalf>
References: <1262129134.28789.96.camel@gandalf>
	 <1262129299.28789.97.camel@gandalf>  <20091229234657.GO3512@atomide.com>
	 <1262130610.28789.116.camel@gandalf>
	 <alpine.DEB.2.00.0912300213530.24862@utopia.booyaka.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59069 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbZL3L4d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Dec 2009 06:56:33 -0500
In-Reply-To: <alpine.DEB.2.00.0912300213530.24862@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi,

On Wed, 2009-12-30 at 02:16 -0700, Paul Walmsley wrote:
> That second 4KiB range is the interconnect target agent between the 
> interconnect and the HS USB OTG IP block.  No need to deal with it.  At 
> some point either omap_hwmod or an interconnect driver will probably 
> reserve it for bookkeeping purposes.

Ok, got it. Thanks for the info.

-- 
balbi

