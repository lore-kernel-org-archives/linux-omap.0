From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v2 2/2] OMAP3: DMA: Errata: sDMA FIFO draining does not finish
Date: Fri, 1 Oct 2010 15:30:27 +0300
Message-ID: <201010011530.28156.peter.ujfalusi@nokia.com>
References: <1285931095-21053-1-git-send-email-peter.ujfalusi@nokia.com> <201010011516.54190.peter.ujfalusi@nokia.com> <20101001122441.GS2925@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63313 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab0JAMag convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 08:30:36 -0400
In-Reply-To: <20101001122441.GS2925@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "balbi@ti.com" <balbi@ti.com>
Cc: "Cohen David (Nokia-MS/Helsinki)" <david.cohen@nokia.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, "Menon, Nishanth" <nm@ti.com>

On Friday 01 October 2010 15:24:41 ext Felipe Balbi wrote:
> I think David is concerned about multiple assigments in one line.
> CodingStyle asks to avoid that. So probably:

Yes, I did noticed that after I've sent the reply.

>=20
> sys_cf =3D dma_read(OCP_SYSCONFIG);
> l =3D sys_cf;
>=20
> would make chekcpatch.pl --strict happy ??

I'll do that. checkpatch.pl without --strict was happy..
Will resend in a moment.

Thanks
--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
