From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v2 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not finish
Date: Fri, 1 Oct 2010 15:43:22 +0300
Message-ID: <201010011543.22374.peter.ujfalusi@nokia.com>
References: <1285931095-21053-1-git-send-email-peter.ujfalusi@nokia.com> <201010011516.54190.peter.ujfalusi@nokia.com> <20101001121716.GB12614@esdhcp036161.research.nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:20790 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932070Ab0JAMn2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 08:43:28 -0400
In-Reply-To: <20101001121716.GB12614@esdhcp036161.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <david.cohen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Nishanth Menon <nm@ti.com>

On Friday 01 October 2010 15:17:16 David Cohen wrote:
> No problem with those two variables, but you're doing multiple
> assignments in one line. You could do something like this:
>=20
> l =3D dma_read(OCP_SYSCONFIG);
> sys_cf =3D l;

I have sent the v3 with this fixed.

Thanks you,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
