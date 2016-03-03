From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 10/11] ARM: DRA7: hwmod: Add data for
 McASP1/2/4/5/6/7/8
Date: Thu, 3 Mar 2016 15:38:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603031532130.32459@utopia.booyaka.com>
References: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com> <1456411827-23962-11-git-send-email-peter.ujfalusi@ti.com> <alpine.DEB.2.02.1603010900590.14948@utopia.booyaka.com> <56D5C6B1.6040005@ti.com> <alpine.DEB.2.02.1603011657260.14948@utopia.booyaka.com>
 <56D81C49.6030706@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-953007988-1457019508=:32459"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56D81C49.6030706-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-953007988-1457019508=:32459
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi P=C3=A9ter,

On Thu, 3 Mar 2016, Peter Ujfalusi wrote:

> On 03/01/2016 07:01 PM, Paul Walmsley wrote:
> >>> 3. Can McASP1,2,3 bus-master onto the L3?  If so, then there should b=
e=20
> >>> "dra7xx_mcasp1__l3_main_1"-style links to indicate this.
> >>
> >> I need to check this, but I don't think McASP1,2,3 can be bus-master o=
nto L3.
> >=20
> > OK.  When you get back, maybe doublecheck this - it looks to me from=20
> > SPRUHZ6 that McASP1-3 have built-in DMA controllers.
>=20
> They are only targets on L3. Not sure about the built-in DMA controller

OK thanks.  I took a closer look at SPRUHZ6E and I think I was mistaken=20
about those blocks having DMA controllers.  So you can ignore this part
of my comments :-)

- Paul
--843723315-953007988-1457019508=:32459--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
