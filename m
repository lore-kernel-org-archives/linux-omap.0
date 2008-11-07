From: David Brownell <david-b@pacbell.net>
Subject: Re: Problems with jffs2 rootfs using 2.6.28-rc3
Date: Fri, 7 Nov 2008 12:46:17 -0800
Message-ID: <200811071246.17303.david-b@pacbell.net>
References: <5e088bd90811071209w6fb1b6c0y689d589819104862@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:28051 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752069AbYKGUqU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 15:46:20 -0500
In-Reply-To: <5e088bd90811071209w6fb1b6c0y689d589819104862@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 07 November 2008, Steve Sakoman wrote:
> I'm having little success. =A0It used to work back in 2.6.26 timefram=
e
> but seems to have broken sometime during 2.6.27.

There's a patch floating around making the omap2 NAND driver
use readsw not readsl, which might explain that problem...

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
