From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: 2.6.37-omap1 tag?
Date: Wed, 12 Jan 2011 22:05:08 +0200
Message-ID: <1294862708.1717.2.camel@eowin>
References: <0C40218E-D65B-4DAE-ABBB-0CB1A02A0E5E@dominion.thruhere.net>
	 <0a8f7e11ed463078411f7692ea233a92@mail.gmail.com>
	 <20110111163454.GS4957@atomide.com>
	 <CA2B2459-D659-4CA9-9D1C-09C65A37DDE6@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44153 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab1ALUFB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jan 2011 15:05:01 -0500
In-Reply-To: <CA2B2459-D659-4CA9-9D1C-09C65A37DDE6@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: Tony Lindgren <tony@atomide.com>, Anand Gadiyar <gadiyar@ti.com>, l-o List <linux-omap@vger.kernel.org>

Hi,

On Wed, 2011-01-12 at 19:03 +0100, Koen Kooi wrote:
> Op 11 jan 2011, om 17:34 heeft Tony Lindgren het volgende geschreven:
> 
> > * Anand Gadiyar <gadiyar@ti.com> [110111 03:04]:
> >> Koen Kooi wrote:
> >>> Are there any plans to do a 2.6.37-omap1 tag?
> >> 
> >> Given that linux-omap is now closely tracking mainline, is
> >> this still needed?
> > 
> > Those tags are no longer needed, the mainline kernel is now the
> > stable kernel and should be used as the base for any distros
> > or products.
> 
> It turns out that l-o head (.37-rc8 currently) and Linus' .37differ a lot, so after spending an evening fruitlessly trying to rebase my patches on top of Linus' .37 I decided to go the other way and just do 'git format-patch v2.6.37-rc8..v2.6.37', apply those on top of l-o rc8 and then rebase my patchset on top of that. That was 5 minutes of work.
> 
> regards,
> 
> Koen--
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
balbi

