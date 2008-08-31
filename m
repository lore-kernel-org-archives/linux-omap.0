From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 04/33] add omap gpio expander driver
Date: Sun, 31 Aug 2008 13:51:52 -0700
Message-ID: <200808311351.53248.david-b@pacbell.net>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <1220116593-862-4-git-send-email-me@felipebalbi.com> <1220116593-862-5-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:27502 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758010AbYHaVTJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 31 Aug 2008 17:19:09 -0400
In-Reply-To: <1220116593-862-5-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

NAK on this one..

On Saturday 30 August 2008, Felipe Balbi wrote:
> --- a/drivers/i2c/chips/Kconfig
> +++ b/drivers/i2c/chips/Kconfig
> @@ -137,6 +137,13 @@ config TPS65010
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0This driver can also be built as a module=
=2E =A0If so, the module
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0will be called tps65010.
> =A0
> +config GPIOEXPANDER_OMAP
> +=A0=A0=A0=A0=A0=A0=A0bool "GPIO Expander PCF8574PWR for OMAP"
> +=A0=A0=A0=A0=A0=A0=A0depends on I2C && (ARCH_OMAP16XX || ARCH_OMAP24=
XX)
> +=A0=A0=A0=A0=A0=A0=A0help
> +=A0=A0=A0=A0=A0=A0=A0 =A0If you say yes here you get support for I/O=
 expander calls
> +=A0=A0=A0=A0=A0=A0=A0 =A0to configure IrDA, Camera and audio devices=
=2E
> +
> =A0config SENSORS_MAX6875
> =A0=A0=A0=A0=A0=A0=A0=A0tristate "Maxim MAX6875 Power supply supervis=
or"
> =A0=A0=A0=A0=A0=A0=A0=A0depends on EXPERIMENTAL

But drivers/gpio/pcf857x.c does just fine for this chip.  Rather
than push this upstream, switch over all users and delete this code.

ISTR having an example patch doing this for H4 boards.  I'll
dig that up and post it when I have time to refresh the code.

The only other user of this hack is the H3 board support.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
