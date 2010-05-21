From: David Brownell <david-b@pacbell.net>
Subject: RE: Re: omap_musb_board_data -- trouble specifying 500mA supply
Date: Fri, 21 May 2010 14:58:28 -0700 (PDT)
Message-ID: <806509.34149.qm@web180310.mail.gq1.yahoo.com>
References: <19F8576C6E063C45BE387C64729E7394044E3514C2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n2-vm1.bullet.mail.gq1.yahoo.com ([67.195.23.155]:24872 "HELO
	n2-vm1.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753040Ab0EUV63 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 May 2010 17:58:29 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E3514C2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Users <linux-omap@vger.kernel.org>, Ajay KumarGupta <ajay.gupta@ti.com>
Cc: Cliff Brake <cliff.brake@gmail.com>


> > >> We are designing a custom OMAP board that
> will have a 500mA supply on
> > >> the OTG port.=A0 It looks like the power
> is set with:
> > >>
> > >> struct omap_musb_board_data {
> > >>=A0 =A0 =A0=A0=A0u8=A0
> =A0 =A0 interface_type;
> > >>=A0 =A0 =A0=A0=A0u8=A0
> =A0 =A0 mode;
> > >>=A0 =A0 =A0=A0=A0u8=A0
> =A0 =A0 power;
> > >> };
> > >>
> > >> However, with a u8, the max value is
> 255.=A0 Should power be changed to a
> > >> u16?

No.  The units are "2mA" not "1mA", matching the USB specs.

So to specify 500mA (the max), say "250" ...



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
