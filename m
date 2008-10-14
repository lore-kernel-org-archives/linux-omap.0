From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 5/8] leds: lp5521: register separate leds
Date: Tue, 14 Oct 2008 08:55:21 -0700
Message-ID: <200810140855.21657.david-b@pacbell.net>
References: <1223989300-27294-1-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-5-git-send-email-felipe.balbi@nokia.com> <1223989300-27294-6-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:27790 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751296AbYJNPzX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2008 11:55:23 -0400
In-Reply-To: <1223989300-27294-6-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

On Tuesday 14 October 2008, Felipe Balbi wrote:
> @@ -23,7 +24,9 @@
> =A0#include <linux/module.h>
> =A0#include <linux/init.h>
> =A0#include <linux/i2c.h>
> +#include <linux/leds.h>
> =A0#include <linux/mutex.h>
> +#include <linux/workqueue.h>
> =A0
> =A0#define LP5521_DRIVER_NAME=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"=
lp5521"
> =A0

Ah, *here* it converts to use the LED framework.  The patch
comment should probably focus on that ... "separate leds" is
just an artifact of that conversion, as I interpret things.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
