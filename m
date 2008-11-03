From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [OMAP and mainline][RFC 2.6.28-rc2-omap 3/3] USB: OHCI-OMAP:
 Switch to gpio_request/free calls
Date: Mon, 3 Nov 2008 13:37:50 +0200
Message-ID: <20081103133750.1d4e66e8.jarkko.nikula@nokia.com>
References: <1225455447-12179-1-git-send-email-jarkko.nikula@nokia.com>
	<1225455447-12179-4-git-send-email-jarkko.nikula@nokia.com>
	<200810311056.55697.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:43872 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbYKCLid convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Nov 2008 06:38:33 -0500
In-Reply-To: <200810311056.55697.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Fri, 31 Oct 2008 10:56:55 -0700
"ext David Brownell" <david-b@pacbell.net> wrote:

> On Friday 31 October 2008, Jarkko Nikula wrote:
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0omap_request_gpio(9);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0gpio_request(9, "USB over current");
>=20
> Make that "OHCI" not "USB" ... and, general comment, shorter
> labels for the GPIOs (12 bytes and less) will preserve column
> alignment in /sys/kernel/debug/gpio listings.
>=20
Thanks Dave! I clearly forgot to clean this one. "OHCI ovcurr", "OHCI
err", etc?

Yes, I actually noted already before making the first set, that
probably I should sent a patch to wide the label column in debugs
listings :-)

Otherwise we have to invent artificially short labels. See e.g.

"BT host wakeup" -> "BT host wup" (looks stupid)
"ADS7846 pendown" -> "ADS7846 pdown", "ADS7846 pd" (power-down?)

IMO GPIO label will be usually longer than IRQ label since label must
include not only chip/connection info but also function of the GPIO.
E.g. "XXX enable", XXX reset", "XXX irq", "LED green", etc.


Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
