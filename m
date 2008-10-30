From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [RFC 19/21] ARM: OMAP: LEDS: Complete gpiolib conversion
Date: Thu, 30 Oct 2008 15:01:04 +0200
Message-ID: <20081030150104.d2927317.jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
	<1225280189-6559-20-git-send-email-jarkko.nikula@nokia.com>
	<200810291046.04058.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29924 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbYJ3NB6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 09:01:58 -0400
In-Reply-To: <200810291046.04058.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Wed, 29 Oct 2008 10:46:03 -0700
"ext David Brownell" <david-b@pacbell.net> wrote:

> On Wednesday 29 October 2008, Jarkko Nikula wrote:
> > =A0arch/arm/mach-omap1/leds.c | =A0 =A04 ++--
>=20
> A file which *certainly* should vanish,
> along with the leds-{h2p2,inn,osk}*.c
> files it supports.
>=20
> This is all for the legacy ARM LED stuff,
> which hasn't worked well at all since we
> converted to the generic time framework
> with its NO_HZ instead of the ARM-only
> version Tony did.
>=20
> Just make it all use leds-gpio.  :)
>=20
Ah, good to know. I then leave this out from my set as well as the
drivers/leds/leds-omap.c.


Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
