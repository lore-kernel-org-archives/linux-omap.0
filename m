From: David Brownell <david-b@pacbell.net>
Subject: Re: [OMAP and mainline][RFC 2.6.28-rc2-omap 3/3] USB: OHCI-OMAP: Switch to gpio_request/free calls
Date: Fri, 31 Oct 2008 10:56:55 -0700
Message-ID: <200810311056.55697.david-b@pacbell.net>
References: <1225455447-12179-1-git-send-email-jarkko.nikula@nokia.com> <1225455447-12179-4-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:21199 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751170AbYJaR5R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Oct 2008 13:57:17 -0400
In-Reply-To: <1225455447-12179-4-git-send-email-jarkko.nikula@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

On Friday 31 October 2008, Jarkko Nikula wrote:
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
omap_request_gpio(9);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
gpio_request(9, "USB over current");

Make that "OHCI" not "USB" ... and, general comment, shorter
labels for the GPIOs (12 bytes and less) will preserve column
alignment in /sys/kernel/debug/gpio listings.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
