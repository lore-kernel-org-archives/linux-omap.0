From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: [RFC][PATCH] usb: musb: pass configuration specifics via pdata
Date: Mon, 30 Jun 2008 22:15:56 +0200
Message-ID: <fb249edb0806301315y79612745jbd23c52f1ff1d775@mail.gmail.com>
References: <1214826653-19005-1-git-send-email-felipe.balbi@nokia.com>
	 <E25964AA-D229-4654-B24B-30A48708B056@student.utwente.nl>
	 <20080630181655.GD4877@kedavra.cpe.vivax.com.br>
	 <200806301133.15860.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:43425 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbYF3UQA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2008 16:16:00 -0400
Received: by ug-out-1314.google.com with SMTP id h2so306961ugf.16
        for <linux-omap@vger.kernel.org>; Mon, 30 Jun 2008 13:15:56 -0700 (PDT)
In-Reply-To: <200806301133.15860.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: David Brownell <david-b@pacbell.net>, Koen Kooi <k.kooi@student.utwente.nl>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Anand Gadiyar <gadiyar@ti.com>, Kevin Hilman <khilman@mvista.com>, Bryan Wu <cooloney@kernel.org>

2008/6/30 David Brownell <david-b@pacbell.net>:
> On Monday 30 June 2008, Felipe Balbi wrote:
>> The patch won't probe. But if you just copy what's added in board-omap3430sdp.c
>> should work.
>
> Better:  that controller data should be provided by SOC glue
> in those cases (omap2430, omap 3*, DaVinci, etc).  If it's
> not board-specific, it doesn't belong in board-specific glue..

Yep, I believe same applies to devices with the TUSB6010 - musb-hdrc
parameters are TUSB6010 specific and not board specific.

Regards
