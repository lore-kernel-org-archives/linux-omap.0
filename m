From: Nishanth Menon <nm@ti.com>
Subject: RE: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Thu, 18 Nov 2010 09:33:42 -0600
Message-ID: <5a0fdb97a16d4c23b22aeeed499ff188@mail.gmail.com>
References: <1290091906-32539-1-git-send-email-j-pihet@ti.com><1290091906-32539-2-git-send-email-j-pihet@ti.com><d2e0f972ca73d80e4929b605a9c2475f@mail.gmail.com><AANLkTimD3pW33NKbOJy+XHuDmLykEFLyviwp2LqNFPzd@mail.gmail.com><d86eedcf8a37a09d3d32552df42938e7@mail.gmail.com>
 <AANLkTinLqGaT3c-fiO=5FN881Bm7WCG05pnV72sfa1P4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:46216 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758957Ab0KRPeR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 10:34:17 -0500
Received: by mail-ew0-f51.google.com with SMTP id 2so2722973ewy.10
        for <linux-omap@vger.kernel.org>; Thu, 18 Nov 2010 07:34:12 -0800 (PST)
In-Reply-To: <AANLkTinLqGaT3c-fiO=5FN881Bm7WCG05pnV72sfa1P4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-omap@vger.kernel.org, Kevin Hillman <khilman@deeprootsystems.com>, Jean Pihet-XID <j-pihet@ti.com>

> -----Original Message-----
> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
> Sent: Thursday, November 18, 2010 9:15 AM

[...]
> >> >>
> >> >> Tested on ZOOM3, OMAP3EVM, Beagleboard, n900
> >> >> with full RET and OFF modes.
> >> >
> >> > Sorry, But I disagree with this patch.
> >> >
> >> > There is a silicon errata which cannot be handled with this - RTA
> >> disable
> >> > - errata i608
> >> >
> >> > You need to disable RTA while coming out of OFF - we cannot handle
> > this
> >> on
> >> >
> >> > GP devices if this is not done.
> >> When you come out of Core off, SRAM contents are anyway lost. So you
> >> have to run from DDR after ROM Code completes. This behavior has not
> >> changed with this patch. I fail to understand your concern here.
> > I could potentially be mistaken. Let me do one thing - I will post out
> the
> >
> > patches that I have to the list and we can see how this all works
> > together
> Ok, fine.
> I did not find any 36xx specific workaround for the errata i608 issue.
> Is there one already available?

Yes, I have a series of patches addressing that as well.. hoping to test
On EMU/HS devices prior to posting - GP devices (3430/3630) tested.
Regards,
Nishanth Menon
