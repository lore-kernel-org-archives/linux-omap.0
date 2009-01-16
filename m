From: David Brownell <david-b@pacbell.net>
Subject: Re: Question on how to best access a chip on init that needs VAUX1 power?
Date: Fri, 16 Jan 2009 13:11:25 -0800
Message-ID: <200901161311.25655.david-b@pacbell.net>
References: <1232134287.347.44.camel@blackhole> <13B9B4C6EF24D648824FF11BE8967162036D6A1527@dlee02.ent.ti.com> <1232139902.347.64.camel@blackhole>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:29219 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759926AbZAPVL1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Jan 2009 16:11:27 -0500
In-Reply-To: <1232139902.347.64.camel@blackhole>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Friday 16 January 2009, Peter Barada wrote:
> Ultimately I should just pull the block of data in u-boot, extract wh=
at
> I need for u-boot, and then pass it to the kernel. =A0Outside of crea=
ting
> a specific ATAG for this, what's the best way to pass a block of data
> from u-boot to the kernel?

kernel command line parameters.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
