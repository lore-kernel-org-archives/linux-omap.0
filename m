From: David Brownell <david-b@pacbell.net>
Subject: Re: [OMAP and mainline][RFC 2.6.28-rc2-omap 3/3] USB: OHCI-OMAP: Switch to gpio_request/free calls
Date: Tue, 11 Nov 2008 22:28:13 -0800
Message-ID: <200811112228.13664.david-b@pacbell.net>
References: <1225455447-12179-1-git-send-email-jarkko.nikula@nokia.com> <200811101423.50989.david-b@pacbell.net> <20081111151737.3dc034d5.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:40453 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750939AbYKLG2P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2008 01:28:15 -0500
In-Reply-To: <20081111151737.3dc034d5.jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 11 November 2008, Jarkko Nikula wrote:
>=20
> > Sure, you send me a drivers/gpio/gpiolib.c update and I'll
> > sign off on it. =A020 chars would be better than 12, but
> > maybe more are needed.
> >=20
> I'll try do as soon as possible. Some "work" and other side stuff has
> unfortunately delayed this gpio & patchset update recently.
>=20
> Do you see are there any issue to change label into last column like
> in /proc/interrupts so that width doesn't have to be fixed?

Only that the amount of data to the right of that label
is variable size too.  I was following a convention that
the standard debug dump code (gpiolib) and the gpio_chip
specific stuff all looked pretty much the same except for
the extras (pullups, pulldowns, drive strength, debounce,
and so on) on the right.

I'd keep it simple and just allow for fatter labels.
Less work all around.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
