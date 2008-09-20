From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/5] watchdog: sync linux-omap changes
Date: Fri, 19 Sep 2008 17:39:06 -0700
Message-ID: <200809191739.06779.david-b@pacbell.net>
References: <1221820359-8943-1-git-send-email-felipe.balbi@nokia.com> <1221820359-8943-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:25082 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752537AbYITAjJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Sep 2008 20:39:09 -0400
In-Reply-To: <1221820359-8943-2-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Wim Van Sebroeck <wim@iguana.be>, Andrew Morton <akpm@linux-foundation.org>, "George G. Davis" <gdavis@mvista.com>

On Friday 19 September 2008, Felipe Balbi wrote:
> +static struct platform_device *omap_wdt_dev;
> +
> =A0...
> +struct omap_wdt_dev {
> +=A0=A0=A0=A0=A0=A0=A0void __iomem =A0 =A0*base; =A0 =A0 =A0 =A0 =A0/=
* physical */
> +=A0=A0=A0=A0=A0=A0=A0struct device =A0 *dev;


You don't need both omap_wdt_dev (platform device)
and omap_wdt_dev.dev (hmm, never used).  In fact
the former isn't needed either ... its role seems
to be ensure only one watchdog device gets bound,
which is more naturally done by not registering
more than one such platform device.
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
