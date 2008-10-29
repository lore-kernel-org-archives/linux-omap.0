From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 01/21] ARM: OMAP: Clean-up OMAP GPIO request/free functions
Date: Wed, 29 Oct 2008 10:49:49 -0700
Message-ID: <200810291049.50101.david-b@pacbell.net>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com> <1225280189-6559-2-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:46297 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753434AbYJ2Rtv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2008 13:49:51 -0400
In-Reply-To: <1225280189-6559-2-git-send-email-jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

Looks OK to me, but I think there's a missing patch:

On Wednesday 29 October 2008, Jarkko Nikula wrote:
> +static inline int omap_request_gpio(int gpio)
> +{
> +=A0=A0=A0=A0=A0=A0=A0return gpio_request(gpio, "FIXME");
> +}
> +
> +static inline void omap_free_gpio(int gpio)
> +{
> +=A0=A0=A0=A0=A0=A0=A0gpio_free(gpio);
> +}
> +

At the end of this patch series, delete these.  :)

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
