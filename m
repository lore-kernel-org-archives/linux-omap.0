From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: omap24xx is broken in current head
Date: Mon, 11 Aug 2008 17:59:30 +0300
Message-ID: <20080811145927.GO7574@frodo>
References: <20080810115818.GG7574@frodo> <20080810121655.GH7574@frodo> <C558C578-1F45-433E-B82F-F5667CEBAFAF@student.utwente.nl> <1218388936.24010.138.camel@localhost> <20080811145053.GL25784@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50834 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbYHKO7w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 10:59:52 -0400
Content-Disposition: inline
In-Reply-To: <20080811145053.GL25784@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Igor Stoppa <igor.stoppa@nokia.com>, ext Koen Kooi <k.kooi@student.utwente.nl>, me@felipebalbi.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, Aug 11, 2008 at 05:50:53PM +0300, Tony Lindgren wrote:
> I'll revert this patch for now to avoid adding a compiler dependency
> as we already have a pile of other issues to solve.
> 
> Let's plan on re-applying this patch once the other issues are out of
> the way.

FYI, I just tried with 2007q3 and had the same issue :-p

I'll try later with vanilla gcc

-- 
balbi
