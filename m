From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/5] I2C: TWL4030: Introduce twl4030 madc driver
Date: Thu, 3 Apr 2008 11:12:49 -0700
Message-ID: <200804031112.49651.david-b@pacbell.net>
References: <1207224865-21527-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:46889 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751913AbYDCSMv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 14:12:51 -0400
In-Reply-To: <1207224865-21527-1-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Mikko Ylinen <mikko.k.ylinen@nokia.com>

On Thursday 03 April 2008, Felipe Balbi wrote:
> + * TWL4030 MADC module driver

What's a "MADC"?  The driver should explain that much,
especially for chips where the documentation isn't being
made generally available.

I'm guessing it's some flavor of ADC... 8 bit?  How
many channels?  Any special features?

