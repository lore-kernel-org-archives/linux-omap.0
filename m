From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v3 1/2] omap: dma: Fix buffering disable bit setting for omap24xx
Date: Mon, 4 Oct 2010 09:15:27 +0300
Message-ID: <201010040915.27745.peter.ujfalusi@nokia.com>
References: <1285936577-14881-1-git-send-email-peter.ujfalusi@nokia.com> <20101004084317.725009ef.jhnikula@gmail.com> <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C865@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48780 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab0JDGQI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 02:16:08 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C865@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>

On Monday 04 October 2010 08:55:46 ext G, Manjunath Kondaiah wrote:
>=20
> 2/2 is applicable for all omap2plus except omap4. So far 2/2 workarou=
nd is
> not used with TI internal trees.
>=20
> > We experimented that also on 2420 and it seemed to help but since t=
he
> > lockup was unrecovable I went thinking if 2420 has also another iss=
ue
> > what original
> > workaround was trying to fix and buffering disable was needed there=
=2E
>=20
> I don't have any data for 2420. Based on your observation, it is bett=
er
> to disable buffering for 2420.

Does the same errata number applies to OMAP2 and OMAP3 as well?
=46or OMAP3 the errata number is i541, but I do not know the iXYZ numbe=
r for OMAP2=20
class.

Thanks,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
