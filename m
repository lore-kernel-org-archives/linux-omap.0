From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 19/21] ARM: OMAP: LEDS: Complete gpiolib conversion
Date: Wed, 29 Oct 2008 10:46:03 -0700
Message-ID: <200810291046.04058.david-b@pacbell.net>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com> <1225280189-6559-20-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:46676 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752621AbYJ2RqL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2008 13:46:11 -0400
In-Reply-To: <1225280189-6559-20-git-send-email-jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

On Wednesday 29 October 2008, Jarkko Nikula wrote:
> =A0arch/arm/mach-omap1/leds.c | =A0 =A04 ++--

A file which *certainly* should vanish,
along with the leds-{h2p2,inn,osk}*.c
files it supports.

This is all for the legacy ARM LED stuff,
which hasn't worked well at all since we
converted to the generic time framework
with its NO_HZ instead of the ARM-only
version Tony did.

Just make it all use leds-gpio.  :)

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
