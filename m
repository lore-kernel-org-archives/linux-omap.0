From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: MMC: recover from transfer failures - Resend
Date: Sun, 8 Feb 2009 12:27:03 -0800
Message-ID: <200902081227.03526.david-b@pacbell.net>
References: <20081207213617.10456.43951.stgit@localhost> <20090205121045.4022c319.akpm@linux-foundation.org> <alpine.DEB.2.00.0902051323090.8131@utopia.booyaka.com>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:39645 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752791AbZBHU1H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Feb 2009 15:27:07 -0500
In-Reply-To: <alpine.DEB.2.00.0902051323090.8131@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jean Pihet <jpihet@mvista.com>, tony@atomide.com, ext-adrian.hunter@nokia.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, jarkko.lavinen@nokia.com, drzeus-mmc@drzeus.cx, linux-kernel@vger.kernel.org

On Thursday 05 February 2009, Paul Walmsley wrote:
>=20
> > > +=A0=A0=A0while (OMAP_HSMMC_READ(host->base,
> > > + =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0SYSCTL) &=
 SRD)
> > > + =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0;
> >=20
> > Is a __raw_readl() sufficient to prevent the cpu from burning up he=
re,
> > or should we add cpu_relax()?
>=20
> The __raw_readl() should be sufficient. =A0The MMC controller is loca=
ted on=20
> the L4 CORE interconnect, so the round trip latency for the read from=
 MMC=20
> is at least 90 ns, while the CPU cycle time is only about 1 to 2 ns.

It's still good policy to have a cpu_relax() in
such loops.  Not that it'll do much on most ARMs,
but empty statements are in general worth avoiding.


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
