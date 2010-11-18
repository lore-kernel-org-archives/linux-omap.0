From: Nishanth Menon <nm@ti.com>
Subject: RE: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Thu, 18 Nov 2010 09:11:31 -0600
Message-ID: <d86eedcf8a37a09d3d32552df42938e7@mail.gmail.com>
References: <1290091906-32539-1-git-send-email-j-pihet@ti.com><1290091906-32539-2-git-send-email-j-pihet@ti.com><d2e0f972ca73d80e4929b605a9c2475f@mail.gmail.com>
 <AANLkTimD3pW33NKbOJy+XHuDmLykEFLyviwp2LqNFPzd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:41683 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752750Ab0KRPMN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 10:12:13 -0500
Received: by yxt3 with SMTP id 3so1914530yxt.28
        for <linux-omap@vger.kernel.org>; Thu, 18 Nov 2010 07:12:10 -0800 (PST)
In-Reply-To: <AANLkTimD3pW33NKbOJy+XHuDmLykEFLyviwp2LqNFPzd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org, Kevin Hillman <khilman@deeprootsystems.com>, Jean Pihet-XID <j-pihet@ti.com>

> -----Original Message-----
> From: Sripathy, Vishwanath [mailto:vishwanath.bs@ti.com]
> Sent: Thursday, November 18, 2010 9:09 AM
> To: Nishanth Menon
> Cc: Jean Pihet; linux-omap@vger.kernel.org; Kevin Hillman; Jean
Pihet-XID
> Subject: Re: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
>
> NIshant,
>
> On Thu, Nov 18, 2010 at 8:27 PM, Nishanth Menon <nm@ti.com> wrote:
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Jean Pihet
> >> Sent: Thursday, November 18, 2010 8:52 AM
> >> To: linux-omap@vger.kernel.org
> >> Cc: Vishwanath BS; Kevin Hillman; Jean Pihet
> >> Subject: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
> >>
> >> From: Vishwanath BS <vishwanath.bs@ti.com>
> >>
> >> For historical reasons the OMAP3 sleep code is run from SRAM.
> >> This code can run from DDR which provides better performance and
> >> leaves the SRAM available for other uses.
> >>
> >> Tested on ZOOM3, OMAP3EVM, Beagleboard, n900
> >> with full RET and OFF modes.
> >
> > Sorry, But I disagree with this patch.
> >
> > There is a silicon errata which cannot be handled with this - RTA
> disable
> > - errata i608
> >
> > You need to disable RTA while coming out of OFF - we cannot handle
this
> on
> >
> > GP devices if this is not done.
> When you come out of Core off, SRAM contents are anyway lost. So you
> have to run from DDR after ROM Code completes. This behavior has not
> changed with this patch. I fail to understand your concern here.
I could potentially be mistaken. Let me do one thing - I will post out the

patches that I have to the list and we can see how this all works
together.

Regards,
Nishanth Menon
