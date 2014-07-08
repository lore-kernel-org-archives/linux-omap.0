From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] ARM: dts: OMAP5: Add device nodes for ABB
Date: Tue, 8 Jul 2014 01:13:28 -0700
Message-ID: <20140708081327.GB28884@atomide.com>
References: <1402017072-12599-1-git-send-email-nm@ti.com>
 <20140707113220.GQ28884@atomide.com>
 <CAGo_u6peyH=VScObgLJxX5kS2J77y5WMsE0O71W4GPDpKaMV=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18964 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbaGHIN0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2014 04:13:26 -0400
Content-Disposition: inline
In-Reply-To: <CAGo_u6peyH=VScObgLJxX5kS2J77y5WMsE0O71W4GPDpKaMV=g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: dt list <devicetree@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>

* Nishanth Menon <nm@ti.com> [140707 07:25]:
> On Mon, Jul 7, 2014 at 6:32 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Nishanth Menon <nm@ti.com> [140605 18:12]:
> >> From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>
> >>
> >> Add ABB device nodes for OMAP5 family of devices. Data is based on
> >> final production OMAP543x Technical Reference Manual revision Z (April 2013).
> >> Final production Data Manual for OMAP5432 SWPS050F(APRIL 2014).
> >>
> >> [nm@ti.com: co-developer and updates to latest documentation]
> >> Signed-off-by: Nishanth Menon <nm@ti.com>
> >> Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
> >> ---
> >> Original patch (v1): https://patchwork.kernel.org/patch/3555191/
> >>
> >> Rest of the series was accepted, however, I had to drop this
> >> previously to ensure that the data we introduce is compatible with
> >> production samples and existing pre-production samples on various
> >> OMAP5uEVMs already in circulation.
> >
> > Is this OK to queue for v3.17 or do we need it for the -rc cycle?
> >
> 
> .17 should be fine Tony. Thanks for following up.

OK applying into omap-for-v3.17/fixes-not-urgent thanks.

Tony
