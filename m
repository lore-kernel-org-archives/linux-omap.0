From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: INTC: Acknowledge stuck active interrupts
Date: Fri, 7 Mar 2014 08:06:00 -0800
Message-ID: <20140307160600.GB3789@atomide.com>
References: <1394119635-24194-1-git-send-email-stefan.sorensen@spectralink.com>
 <20140306183235.GB1381@atomide.com>
 <1394196081.2692.2.camel@e37108.spectralink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46885 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbaCGQGG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Mar 2014 11:06:06 -0500
Content-Disposition: inline
In-Reply-To: <1394196081.2692.2.camel@e37108.spectralink.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?utf-8?Q?S=C3=B8rensen=2C?= Stefan <Stefan.Sorensen@spectralink.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* S=C3=B8rensen, Stefan <Stefan.Sorensen@spectralink.com> [140307 04:44=
]:
> On Thu, 2014-03-06 at 10:32 -0800, Tony Lindgren wrote:
> > While playing with this, you may want to also do one more test and
> > forward port these two patches adding checks for spurious interrupt=
s:
> >=20
> > 6ccc4c0d ARM: OMAP3: Warn about spurious interrupts
> > 846c29f1 ARM: OMAP3: Clean up spurious interrupt check logic
> >=20
> > Those got removed in commit:
> >=20
> > 667a11fa arm: omap2/3: Use generic irq chip
> >=20
> > If you get warnings with those checks about spurious interrupts the=
re's
> > also something else wrong or we're not understanding the problem fu=
lly.
> > So it might be good to check before we apply this patch.
>=20
> No warnings with those patches. I also tried watching the spuriousirq
> field in various places - nothing showed up.

OK thanks for testing, that's good to hear.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
