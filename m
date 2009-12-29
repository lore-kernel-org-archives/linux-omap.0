From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] OMAP2: add USB platform data and initialization for
 Nokia N800 and N810
Date: Tue, 29 Dec 2009 22:35:50 +0200
Message-ID: <1262118950.28789.86.camel@gandalf>
References: <200912290152.16357.luke@dashjr.org>
	 <20091229192407.GA3512@atomide.com>  <200912291428.30133.luke@dashjr.org>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:41631 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbZL2Ufz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 15:35:55 -0500
In-Reply-To: <200912291428.30133.luke@dashjr.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: Tony Lindgren <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Kalle Valo <kalle.valo@iki.fi>

On Tue, 2009-12-29 at 14:28 -0600, Luke-Jr wrote:
> Quick followup... I haven't had the chance to make those clock changes or move 
> it into the main board file yet, but just discovered my recent boot problems 
> were "fixed" by disabling USB support, so apparently there's something else 
> broken with my patch. :(
> 
> Unfortunately, without a trackback, I'm totally lost:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000031
> pgd = c0004000
> [00000031] *pgd=000000000
> Internal error: Oops: 17 [#1] PREEMPT

can you post the entire trace ?

I need the function call trace that BUG() prints

-- 
balbi

