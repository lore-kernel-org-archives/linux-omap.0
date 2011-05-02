From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/1] OMAP3: rx-51: Add full regulator definitions
Date: Mon, 2 May 2011 09:57:27 +0300
Message-ID: <20110502095727.7f679550.jhnikula@gmail.com>
References: <1304081264-4915-1-git-send-email-kalle.jokiniemi@nokia.com>
	<1304081264-4915-2-git-send-email-kalle.jokiniemi@nokia.com>
	<20110429170409.5ad8833b.jhnikula@gmail.com>
	<9D0D31AA57AAF5499AFDC63D6472631B09CE3E@008-AM1MPN1-036.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44814 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592Ab1EBG5c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 May 2011 02:57:32 -0400
Received: by eyx24 with SMTP id 24so1656539eyx.19
        for <linux-omap@vger.kernel.org>; Sun, 01 May 2011 23:57:31 -0700 (PDT)
In-Reply-To: <9D0D31AA57AAF5499AFDC63D6472631B09CE3E@008-AM1MPN1-036.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kalle.jokiniemi@nokia.com
Cc: tony@atomide.com, Sakari.Ailus@nokia.com, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com

On Mon, 2 May 2011 05:19:46 +0000
<kalle.jokiniemi@nokia.com> wrote:

> It seems I was not answering your question quite rightly... So these are used
> to power some internal blocks inside the TWL5030. The dependencies there
> are not very well documented, so it's best to leave them be. I think these
> could be turned off via the power scripts during OFF mode (if we would be
> using that).
> 
Sounds safe assumption for those two. Also I don't point out from
public schematics where are the vintana2 and vpll2 routed so looks like
need keep them on as well.

-- 
Jarkko
