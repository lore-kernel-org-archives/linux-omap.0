From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/7] input: tsc2005: move to gpiolib
Date: Tue, 14 Oct 2008 16:20:04 -0700
Message-ID: <200810141620.04834.david-b@pacbell.net>
References: <1224020397-2842-1-git-send-email-me@felipebalbi.com> <1224020397-2842-2-git-send-email-me@felipebalbi.com> <1224020397-2842-3-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:27783 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755311AbYJNXUH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2008 19:20:07 -0400
In-Reply-To: <1224020397-2842-3-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tuesday 14 October 2008, Felipe Balbi wrote:
> -=A0=A0=A0=A0=A0=A0=A0omap_set_gpio_direction(dav_gpio, 1);
> +=A0=A0=A0=A0=A0=A0=A0gpio_direction_input(dav_gpio);
> =A0=A0=A0=A0=A0=A0=A0=A0ts->irq =3D OMAP_GPIO_IRQ(dav_gpio);

That should be ts->irq =3D gpio_to_irq(dav_gpio) ...

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
