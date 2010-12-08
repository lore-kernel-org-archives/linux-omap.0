From: Hari Kanigeri <hari.kanigeri@gmail.com>
Subject: Re: [PATCH 2/7] usb: otg: Adding twl6030-usb transceiver driver for
Date: Tue, 7 Dec 2010 20:00:55 -0600
Message-ID: <AANLkTimMuzhF4mQjJ61kw=SaB21gJati8hCD1RYjzWVB@mail.gmail.com>
References: <1291767062-10106-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f194.google.com ([209.85.214.194]:36088 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756366Ab0LHCA4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 21:00:56 -0500
In-Reply-To: <1291767062-10106-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb-owner@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>

Hema,

On Tue, Dec 7, 2010 at 6:11 PM, Hema HK <hemahk@ti.com> wrote:
> Adding the twl6030-usb transceiver support for OMAP4 musb driver.
>
> OMAP4 supports 2 types of transceiver interface.

> +}
> +
> +int omap4430_phy_set_clk(struct device *dev, int on)
> +{
> + =A0 =A0 =A0 static int state;

probably good to initialize to zero.

> +
> + =A0 =A0 =A0 if (on && !state) {

Thank you,
Best regards,
Hari
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
