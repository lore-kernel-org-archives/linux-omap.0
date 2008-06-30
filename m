From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC][PATCH] usb: musb: pass configuration specifics via pdata
Date: Mon, 30 Jun 2008 11:33:15 -0700
Message-ID: <200806301133.15860.david-b@pacbell.net>
References: <1214826653-19005-1-git-send-email-felipe.balbi@nokia.com> <E25964AA-D229-4654-B24B-30A48708B056@student.utwente.nl> <20080630181655.GD4877@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:28783 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752771AbYF3SdS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jun 2008 14:33:18 -0400
In-Reply-To: <20080630181655.GD4877@kedavra.cpe.vivax.com.br>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Koen Kooi <k.kooi@student.utwente.nl>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Anand Gadiyar <gadiyar@ti.com>, Kevin Hilman <khilman@mvista.com>, Bryan Wu <cooloney@kernel.org>

On Monday 30 June 2008, Felipe Balbi wrote:
> The patch won't probe. But if you just copy what's added in board-omap3430sdp.c
> should work.

Better:  that controller data should be provided by SOC glue
in those cases (omap2430, omap 3*, DaVinci, etc).  If it's
not board-specific, it doesn't belong in board-specific glue..

