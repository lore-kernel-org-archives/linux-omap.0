From: David Brownell <david-b@pacbell.net>
Subject: Re: [OMAP and mainline][RFC 2.6.28-rc2-omap 3/3] USB: OHCI-OMAP: Switch to gpio_request/free calls
Date: Mon, 10 Nov 2008 14:23:50 -0800
Message-ID: <200811101423.50989.david-b@pacbell.net>
References: <1225455447-12179-1-git-send-email-jarkko.nikula@nokia.com> <200810311056.55697.david-b@pacbell.net> <20081103133750.1d4e66e8.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:41257 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751068AbYKJWtV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Nov 2008 17:49:21 -0500
In-Reply-To: <20081103133750.1d4e66e8.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

On Monday 03 November 2008, Jarkko Nikula wrote:
> Yes, I actually noted already before making the first set, that
> probably I should sent a patch to wide the label column in debugs
> listings :-)

Sure, you send me a drivers/gpio/gpiolib.c update and I'll
sign off on it.  20 chars would be better than 12, but
maybe more are needed.

