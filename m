From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2+: AM43xx hwmod: Add RTC hwmod for
 AM43xx
Date: Sat, 7 Mar 2015 00:37:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1503070037240.20994@utopia.booyaka.com>
References: <1425561211-31003-1-git-send-email-d-gerlach@ti.com> <1425561211-31003-3-git-send-email-d-gerlach@ti.com> <alpine.DEB.2.02.1503060425590.5613@utopia.booyaka.com> <54F9E41B.5010805@ti.com> <alpine.DEB.2.02.1503061743170.20994@utopia.booyaka.com>
 <54F9E8DF.4000009@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58266 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756252AbbCGAh6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 19:37:58 -0500
In-Reply-To: <54F9E8DF.4000009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, KEERTHY <j-keerthy@ti.com>

On Fri, 6 Mar 2015, Dave Gerlach wrote:

> On 03/06/2015 11:44 AM, Paul Walmsley wrote:
> > On Fri, 6 Mar 2015, Dave Gerlach wrote:
> >> On 03/05/2015 10:26 PM, Paul Walmsley wrote:
> >>> On Thu, 5 Mar 2015, Dave Gerlach wrote:
> >>>
> >>>> RTC hwmod is needed for proper operation of PM features like
> >>>> rtcwake and rtc-only mode so reuse the am33xx rtc hwmod.
> >>>>
> >>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> >>>
> >>> Thanks, queued for v4.1.
> >>
> >> Thanks, but please note as I just commented in Patch 1 of this series, without
> >> the ti,no-init flag in place that is introduced there this patch will cause the
> >> am43x-epos-evm to fail to boot.
> > 
> > If that's so, shouldn't it appear in the series after patch 3, then?  
> > If only patches 1 and 2 are applied, then won't the boot be broken on 
> > am43x-epos-evm ?
> 
> Hmm yes you are correct that would be the case, seems I should have swapped the
> order. I've gotten into the habit of putting dt patches last to enable what gets
> introduced previously, guess it's not always the best thing to do. Thanks for
> pointing this out.

OK dropped until this thing is sorted out.


- Paul
