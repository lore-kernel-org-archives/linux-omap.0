From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC][PATCH] usb: musb: pass configuration specifics via pdata
Date: Mon, 30 Jun 2008 21:16:56 +0300
Message-ID: <20080630181655.GD4877@kedavra.cpe.vivax.com.br>
References: <1214826653-19005-1-git-send-email-felipe.balbi@nokia.com> <E4E2FDD8-E1E5-4601-A0B0-D2FC7B27C7C3@student.utwente.nl> <20080630174859.GC4877@kedavra.cpe.vivax.com.br> <E25964AA-D229-4654-B24B-30A48708B056@student.utwente.nl>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46757 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbYF3SRL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2008 14:17:11 -0400
Content-Disposition: inline
In-Reply-To: <E25964AA-D229-4654-B24B-30A48708B056@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: me@felipebalbi.com, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgre <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Anand Gadiyar <gadiyar@ti.com>, Kevin Hilman <khilman@mvista.com>, Bryan Wu <cooloney@kernel.org>

On Mon, Jun 30, 2008 at 07:56:36PM +0200, Koen Kooi wrote:
> I was wondering what would happen if I would test the patch  on  
> beagleboard, now I know :)

The patch won't probe. But if you just copy what's added in board-omap3430sdp.c
should work.

afaict, they have the same configuration for musb.

I'll try to finish tomorrow the other boards.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
