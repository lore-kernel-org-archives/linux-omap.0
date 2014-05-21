From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/6] AM43xx & OMAP5 DSS DT changes
Date: Wed, 21 May 2014 08:41:54 -0700
Message-ID: <20140521154153.GK17417@atomide.com>
References: <1400676625-30078-1-git-send-email-tomi.valkeinen@ti.com>
 <20140521150231.GH17417@atomide.com>
 <537CC376.5050501@ti.com>
 <20140521152613.GJ17417@atomide.com>
 <537CC6E7.6010103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27537 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbaEUPl6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2014 11:41:58 -0400
Content-Disposition: inline
In-Reply-To: <537CC6E7.6010103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140521 08:33]:
> On 21/05/14 18:26, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [140521 08:18]:
> >> On 21/05/14 18:02, Tony Lindgren wrote:
> >>> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140521 05:51]:
> >>>> Hi,
> >>>>
> >>>> Here are the AM43xx and OMAP5 display DT changes again. I've sent the clock
> >>>> related changes separately, and I removed OMAP5's RFBI node, which depends on
> >>>> more clock changes. The RFBI driver doesn't work at the moment anyway, so
> >>>> removing the RFBI node should not be an issue.
> >>>>
> >>>> Tony, if these look fine (the rfbi change is the only one compared to the
> >>>> previous versions), can you queue them for 3.16?
> >>>
> >>> Probably best that you do a late branch again after arm-soc dts changes
> >>> have been merged. Sounds like you have at least that macro dependency
> >>> to omap-for-v3.16/dt-v2 so you should probably base your branch on
> >>
> >> There are no dependencies that I know of. Which macro dependency is that?
> > 
> > Oh for the "[PATCH v2] ARM: dts: duovero-parlor: Add HDMI output" that
> > now uses the OMAP4_IOPAD macro.
> 
> Ok.
> 
> But generally, isn't it better if the .dts changes go through your tree?
> None of the display related .dts changes have any dependencies to
> omapdss as such.

Yes in general, but it's getting very late for v3.16, and..
 
> I can collect the patches, as I've done, to let them mature a bit in my
> tree, but I'd rather get them merged via your dt branch.

..I may not queue any more patches for v3.16. The branches I've sent have
not yet been merged into arm-soc, so at minimum I'm going to wait for
that. If we have -rc6 tagged today and no -rc7, I'm switching into fixes
only mode. So in this case it's probably best that you merge them so
we can get the display dependency out of the way for v3.16.

Regards,

Tony 

