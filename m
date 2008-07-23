From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [i2c] N800 problems with MMC, LM8323 on current linux-omap git head
Date: Wed, 23 Jul 2008 05:10:57 -0500
Message-ID: <0487ae10263d239a8a891c9ed068da1c@felipebalbi.com>
References: <20080722124743.GA5820@kos.to> <90eb4be1e5a489819f08e76ad872e920@felipebalbi.com> <20080722133742.GA7492@kos.to> <20080722134314.GC8318@fluff.org.uk> <eb09f11f1e5a25903cfd4c2157ecbba5@felipebalbi.com> <20080723093849.GA13505@kos.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:54706 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbYGWKLE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jul 2008 06:11:04 -0400
In-Reply-To: <20080723093849.GA13505@kos.to>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Riku Voipio <riku.voipio@iki.fi>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, i2c@lm-sensors.org



On Wed, 23 Jul 2008 12:38:49 +0300, Riku Voipio <riku.voipio@iki.fi> wrote:
> Indeed - compared to my previous version, this one makes the boardfile
> even smaller:
> 
>    text    data     bss     dec     hex filename
>    2362    1552       4    3918     f4e
> old/arch/arm/mach-omap2/board-n800.o
>    2354    1456       4    3814     ee6
> new/arch/arm/mach-omap2/board-n800.o

Cool :-)

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

-- 
Best Regards,

Felipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com

