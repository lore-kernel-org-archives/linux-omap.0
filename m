From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/1] TWL: USB: disable VUSB regulators
Date: Wed, 21 Jan 2009 12:38:32 -0800
Message-ID: <200901211238.33229.david-b@pacbell.net>
References: <1232543718-18199-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:37275 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751319AbZAUUig (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Jan 2009 15:38:36 -0500
In-Reply-To: <1232543718-18199-1-git-send-email-kalle.jokiniemi@digia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com

On Wednesday 21 January 2009, Kalle Jokiniemi wrote:
> The TWL5030/4030 internal VUSB regulators are eating current
> like small piggies.

Feral pigs are a big problem in many places ...
no surprise that feral code is too!


> The following patch makes an aptempt at 
> making the twl4030-usb consumer driver dynamically disable
> and enable the regulators it needs.

Thanks, I'll have a look.  It's a bit different
from some old hacks I didn't finish debugging.

Shouldn't the power down sequence mirror the
power up sequence?  Up 1.5, 1.8, 3.1 ... then
down 3.1, 1.8, 1.5?  Or does that matter?

Also, I'm thinking that the DEV_GRP and TYPE
register updates belong in regulator code, not
transceiver code.  That's something to take care
of with a separate patch though.

- Dave
