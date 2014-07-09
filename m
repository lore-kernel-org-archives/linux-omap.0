From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [Re-send PATCH 1/1] arm: dra7xx: Add hwmod data for MDIO and CPSW
Date: Wed, 9 Jul 2014 03:11:16 -0700
Message-ID: <20140709101116.GM28884@atomide.com>
References: <1404825399-10330-1-git-send-email-mugunthanvnm@ti.com>
 <20140709095552.GA25154@breakpoint.cc>
 <20140709100147.GB25154@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140709100147.GB25154-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
Cc: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org> [140709 03:03]:
> On 2014-07-09 11:55:52 [+0200], Sebastian Andrzej Siewior wrote:
> > On 2014-07-08 18:46:39 [+0530], Mugunthan V N wrote:
> > > Adding hwmod data for CPSW and MDIO which is present in DRA7xx So=
C
> >=20
> > I reverted my patch, applied this one and after boot I got:
> Oh me dum dum. I had --dry-run=E2=80=A6
>=20
> Acked-by: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
>=20
> This is basically what Tony hasked me to do: No IRQ numbers & iomem.

OK great thanks for testing :)

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
