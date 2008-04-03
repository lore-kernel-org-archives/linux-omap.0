From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/5] I2C: TWL4030: Kconfig and Makefile changes
Date: Thu, 3 Apr 2008 11:13:10 -0700
Message-ID: <200804031113.11115.david-b@pacbell.net>
References: <1207224865-21527-1-git-send-email-felipe.balbi@nokia.com> <1207224865-21527-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:20553 "HELO
	smtp111.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755456AbYDCSNO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 14:13:14 -0400
In-Reply-To: <1207224865-21527-2-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Mikko Ylinen <mikko.k.ylinen@nokia.com>

On Thursday 03 April 2008, Felipe Balbi wrote:
> +config TWL4030_MADC
> +=A0=A0=A0=A0=A0=A0=A0tristate "TWL4030 MADC Driver"
> +=A0=A0=A0=A0=A0=A0=A0depends on TWL4030_CORE
> +

Again, what's a MADC?

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
