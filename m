From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v2 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not finish
Date: Fri, 1 Oct 2010 15:16:53 +0300
Message-ID: <201010011516.54190.peter.ujfalusi@nokia.com>
References: <1285931095-21053-1-git-send-email-peter.ujfalusi@nokia.com> <1285931095-21053-3-git-send-email-peter.ujfalusi@nokia.com> <20101001115037.GA12614@esdhcp036161.research.nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:25828 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932092Ab0JAMQz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 08:16:55 -0400
In-Reply-To: <20101001115037.GA12614@esdhcp036161.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <david.cohen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Nishanth Menon <nm@ti.com>

On Friday 01 October 2010 14:50:37 David Cohen wrote:
>=20
> > +		l =3D sys_cf =3D dma_read(OCP_SYSCONFIG);
>=20
> Shouldn't it be avoided?

I'm restoring the OCP_SYSCONFIG register later on, and reusing 'l' here=
 to avoid=20
confusing expression when moving the sDMA to NoStandby.
I could as well introduce other variable for this...

>=20
> Regards,
>=20
> David
>=20
> > +		l &=3D ~DMA_SYSCONFIG_MIDLEMODE_MASK;
> > +		l |=3D DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE);
> > +		dma_write(l , OCP_SYSCONFIG);

I could have:
	dma_write((sys_fc & (~DMA_SYSCONFIG_MIDLEMODE_MASK)) |
			 DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE), OCP_SYSCONFIG);

Than I do not need the re-read the CCR, but it looks a bit messy.

> > +
> > +		l =3D dma_read(CCR(lch));
> > +		l &=3D ~OMAP_DMA_CCR_EN;
> > +		dma_write(l, CCR(lch));
> > +

=2E..

> > +		/* Restore OCP_SYSCONFIG */
> > +		dma_write(sys_cf, OCP_SYSCONFIG);

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
