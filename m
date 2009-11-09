From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [alsa-devel] [PATCH] OMAP: McBSP: Do not use extensive spin locks for dma_op_mode
Date: Mon, 9 Nov 2009 09:49:11 +0200
Message-ID: <200911090949.11680.peter.ujfalusi@nokia.com>
References: <1256641215-26131-1-git-send-email-peter.ujfalusi@nokia.com> <200910290835.51475.peter.ujfalusi@nokia.com> <20091029091524.a663e4e5.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41781 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbZKIHtS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 02:49:18 -0500
In-Reply-To: <20091029091524.a663e4e5.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

On Thursday 29 October 2009 09:15:24 ext Jarkko Nikula wrote:
> On Thu, 29 Oct 2009 08:35:51 +0200
>=20
> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> > > The spinlocks are unnecessary. In the above example, you get the =
same
> > > with just "return mcbsp->dma_op_mode;"
> > >
> > > -> Peter's patch is a good cleanup.
> >
> > Jarkko: are we going to take this?
>=20
> Yep, you can have my
>=20
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>

Just want to bring up this thread.
Should I resend the patch?

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
