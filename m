From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/4] OMAP: MENELAUS: Improvements on menelaus
Date: Tue, 29 Jul 2008 21:37:18 +0300
Message-ID: <20080729183717.GB7275@frodo>
References: <488F48E3.2060504@indt.org.br>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47745 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbYG2Sh3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2008 14:37:29 -0400
Content-Disposition: inline
In-Reply-To: <488F48E3.2060504@indt.org.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Tue, Jul 29, 2008 at 12:44:19PM -0400, Carlos Aguiar wrote:
> Hi Tony and folks,
>
> This patch series proposes some improvements on menelaus code.
>
> Basically it makes menelaus to use macros instead of some magic constant  
> numbers, making menelaus code more legible. The menelaus header was  
> moved to include/linux/i2c and register map (including the macros  
> created) were moved to include/linux/i2c/menelaus.h
>
> Tested with MMC on N800 and looks fine.

They look quite ok. How about syncing l-o menelaus with mainline via
lm-sensors mailing list and discuss all these there as well ??

It'd be only one extra patch before this one to make everything in sync.

-- 
balbi
