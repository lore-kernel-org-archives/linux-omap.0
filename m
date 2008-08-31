From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 12/33] Add tsc2005 touchscreen driver
Date: Sun, 31 Aug 2008 13:53:37 -0700
Message-ID: <200808311353.37569.david-b@pacbell.net>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <1220116593-862-12-git-send-email-me@felipebalbi.com> <1220116593-862-13-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:27512 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758076AbYHaVTK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 31 Aug 2008 17:19:10 -0400
In-Reply-To: <1220116593-862-13-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Saturday 30 August 2008, Felipe Balbi wrote:
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -217,6 +217,11 @@ config TOUCHSCREEN_ATMEL_TSADCC
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0To compile this driver as a module, choos=
e M here: the
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0module will be called atmel_tsadcc.
> =A0
> +config TOUCHSCREEN_TSC2005
> +=A0=A0=A0=A0=A0=A0=A0tristate "TSC2005 touchscreen support"
> +=A0=A0=A0=A0=A0=A0=A0help
> +=A0=A0=A0=A0=A0=A0=A0 =A0Say Y here for if you are using the touchsc=
reen features of TSC2301

TSC 2301 or 2005?
And shouldn't there be a TSC 2301 or 2005 driver to depend on?

> +
> =A0config TOUCHSCREEN_UCB1400
> =A0=A0=A0=A0=A0=A0=A0=A0tristate "Philips UCB1400 touchscreen"
> =A0=A0=A0=A0=A0=A0=A0=A0select AC97_BUS


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
