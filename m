From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 29/33] add omap ehci bus glue
Date: Sun, 31 Aug 2008 14:09:42 -0700
Message-ID: <200808311409.42950.david-b@pacbell.net>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <1220116593-862-29-git-send-email-me@felipebalbi.com> <1220116593-862-30-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:27540 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758113AbYHaVTP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 31 Aug 2008 17:19:15 -0400
In-Reply-To: <1220116593-862-30-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Saturday 30 August 2008, Felipe Balbi wrote:
> +choice
> +=A0=A0=A0=A0=A0=A0=A0prompt "PHY/TLL mode"
> +=A0=A0=A0=A0=A0=A0=A0depends on USB_EHCI_HCD && EXPERIMENTAL && ARCH=
_OMAP34XX
> +=A0=A0=A0=A0=A0=A0=A0---help---
> +=A0=A0=A0=A0=A0=A0=A0Choose PHY or TLL mode of operation
> +
> +config OMAP_EHCI_PHY_MODE
> +=A0=A0=A0=A0=A0=A0=A0bool "PHY mode: ISP1504 on Port1/2 (NEW 3430ES2=
=2E0)"
> +=A0=A0=A0=A0=A0=A0=A0depends on USB_EHCI_HCD && EXPERIMENTAL && ARCH=
_OMAP34XX
> +=A0=A0=A0=A0=A0=A0=A0---help---
> +=A0=A0=A0=A0=A0=A0=A0 =A0EHCI PHY mode. Port1 and Port2 are connecte=
d to ISP1504 transcievers
> +
> +config OMAP_EHCI_TLL_MODE
> +=A0=A0=A0=A0=A0=A0=A0bool "TLL mode: (EXPERIMENTAL)"
> +=A0=A0=A0=A0=A0=A0=A0depends on USB_EHCI_HCD && EXPERIMENTAL && ARCH=
_OMAP34XX
> +=A0=A0=A0=A0=A0=A0=A0---help---
> +=A0=A0=A0=A0=A0=A0=A0OMAP EHCI controller has TLL mode of operation =
for all 3 ports.
> +=A0=A0=A0=A0=A0=A0=A0Use this mode when no transciever is present

All that stuff should be platform data, not Kconfig options.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
