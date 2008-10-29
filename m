From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 10/21] LEDS: Complete leds-omap gpiolib conversion and do some fixes
Date: Wed, 29 Oct 2008 10:15:36 -0700
Message-ID: <200810291015.36910.david-b@pacbell.net>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com> <1225280189-6559-11-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:29229 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752860AbYJ2RPj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2008 13:15:39 -0400
In-Reply-To: <1225280189-6559-11-git-send-email-jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

On Wednesday 29 October 2008, Jarkko Nikula wrote:
> =A0drivers/leds/leds-omap.c | =A0 24 +++++++++++-------------

I'd have expected this driver to vanish completely ...
is there something this driver does that leds-gpio.c can't?

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
