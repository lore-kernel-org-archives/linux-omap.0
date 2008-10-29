From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 21/21] ARM: OMAP: Complete debug board gpiolib conversion
Date: Wed, 29 Oct 2008 10:19:44 -0700
Message-ID: <200810291019.44735.david-b@pacbell.net>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com> <1225280189-6559-22-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:28761 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752788AbYJ2RTq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2008 13:19:46 -0400
In-Reply-To: <1225280189-6559-22-git-send-email-jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

On Wednesday 29 October 2008, Jarkko Nikula wrote:
> -=A0=A0=A0=A0=A0=A0=A0status =3D omap_request_gpio(gpio);
> +=A0=A0=A0=A0=A0=A0=A0status =3D gpio_request(gpio, "SMC91x irq");

OK, that IRQ is actually shared among all the IRQ sources on
the debug board ... notably, its four serial ports share it.
So I'd use a different label.  :)

I'm working on a slightly different patch, to make all the
=46PGA GPIOs plug in to the GPIO framework, but that can
easily go on top of this.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
