From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/2] twl4030-madc fixes
Date: Sun, 22 Feb 2009 13:59:33 -0800
Message-ID: <200902221359.33590.david-b@pacbell.net>
References: <499EB9EB.4050008@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:46445 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752368AbZBVV7f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 22 Feb 2009 16:59:35 -0500
In-Reply-To: <499EB9EB.4050008@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 20 February 2009, Aaro Koskinen wrote:
> Hello,
> 
> Two fixes for twl4030-madc:
> 
> - The first one converts the ioctl to unlocked one.
> 
> - The second one should return the conversion status to user quicker, 
> both in OK and timeout cases. There's also fix for the timeout case 
> (currently the request remains active) and some cleanup.

They both look OK to me.
