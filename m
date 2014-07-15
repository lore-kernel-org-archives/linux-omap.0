From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Re-send PATCH 1/1] arm: dra7xx: Add hwmod data for MDIO and
 CPSW
Date: Tue, 15 Jul 2014 20:21:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407152019020.21432@utopia.booyaka.com>
References: <1404825399-10330-1-git-send-email-mugunthanvnm@ti.com> <20140709095552.GA25154@breakpoint.cc> <20140709100147.GB25154@breakpoint.cc>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-788041059-1405455633=:21432"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140709100147.GB25154-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
Content-ID: <alpine.DEB.2.02.1407152020410.21432-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-788041059-1405455633=:21432
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.02.1407152020411.21432-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>

Hi Sebastian,

On Wed, 9 Jul 2014, Sebastian Andrzej Siewior wrote:

> On 2014-07-09 11:55:52 [+0200], Sebastian Andrzej Siewior wrote:
> > On 2014-07-08 18:46:39 [+0530], Mugunthan V N wrote:
> > > Adding hwmod data for CPSW and MDIO which is present in DRA7xx SoC
> >=20
> > I reverted my patch, applied this one and after boot I got:
> Oh me dum dum. I had --dry-run=E2=80=A6
>=20
> Acked-by: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
>=20
> This is basically what Tony hasked me to do: No IRQ numbers & iomem.

Sorry - I'm a bit confused - Sebastian, did you test this one?  If so, is=
=20
it okay to add a Tested-by from you?

Mugunthan, could you please get a Reviewed-by: from one of the folks on=20
the DRA7xx SoC integration reviewers list that I sent earlier?


- Paul
--843723315-788041059-1405455633=:21432--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
