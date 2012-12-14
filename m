From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: omap2plus_defconfig: enable twl4030
 SoC audio
Date: Thu, 13 Dec 2012 16:02:41 -0800
Message-ID: <20121214000240.GJ4989@atomide.com>
References: <1353979275-6237-1-git-send-email-javier.martinez@collabora.co.uk>
 <50B48EB2.1040804@ti.com>
 <CAAwP0s2p+eSe5Xzip+vOtOhKFNsbdLsqcHy7CcFVv7O8CAXmdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21736 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756309Ab2LNACr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Dec 2012 19:02:47 -0500
Content-Disposition: inline
In-Reply-To: <CAAwP0s2p+eSe5Xzip+vOtOhKFNsbdLsqcHy7CcFVv7O8CAXmdA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Javier Martinez Canillas <martinez.javier@gmail.com> [121213 16:01]:
> On Tue, Nov 27, 2012 at 10:58 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> > On 11/27/2012 02:21 AM, Javier Martinez Canillas wrote:
> >> Many TI OMAP SoC based boards that uses twl4030 as codec have
> >> been updated to use the unified audio driver (omap-twl4030)
> >> since they have similar audio setup.
> >>
> >> So, is good to have it built to add audio support to these boards.
> >>
> >> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> >
> > I also agree that it is a good practice to enable this in the defconfig.
> >
> > Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >
> 
> Hi Tony,
> 
> Any comments on this patch?

No looks just fine to me. Let's see if we can get it merged after
the merge window related issues are dealt with.

Regards,

Tony
