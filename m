From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: RE: Pull request for OMAP PM, clock, SDRC 2.6.32 patches
Date: Tue, 18 Aug 2009 17:27:19 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908181720460.23762@utopia.booyaka.com>
References: <alpine.DEB.2.00.0908160737380.31720@utopia.booyaka.com> <20090817170921.GT10764@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0908180621270.7224@utopia.booyaka.com> <13B9B4C6EF24D648824FF11BE89671620399F63372@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620399F63372-EovWT4A8QTWIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Woodruff, Richard" <r-woodruff2-l0cyMroinI0@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org" <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>, "linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "hiroshi.doyu-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <hiroshi.doyu-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Richard,

On Tue, 18 Aug 2009, Woodruff, Richard wrote:

> > -----Original Message-----
> > From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-
> > owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Paul Walmsley
> > Sent: Tuesday, August 18, 2009 7:36 AM
> > To: Russell King - ARM Linux
> 
> > I've dropped the two patches that are being discussed and reposted the
> > remainder.  The updated series is here (et seq.):
> >
> >     http://marc.info/?l=linux-arm-kernel&m=125059872200340&w=2
> >
> > and the pull request is here:
> >
> >     http://marc.info/?l=linux-arm-kernel&m=125059845132331&w=2
> 
> Does this series conflict with patches already submitted on OMAP4?
> 
> http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg15488.html
> 
> I'm not able to check now but its best to be careful here.

The series cannot conflict with Rajendra's patches 1-3, since there are no 
files in common between the two series.  As for patches 4-6, there are 
comments pending:

http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg15568.html


- Paul
--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
