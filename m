From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP4: clock data: Lock ABE DPLL on all
 revisions
Date: Fri, 4 Jan 2013 17:18:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301041717410.25868@utopia.booyaka.com>
References: <1357294163-4317-1-git-send-email-peter.ujfalusi@ti.com> <1357294163-4317-2-git-send-email-peter.ujfalusi@ti.com> <50E6F0CA.60309@ti.com> <50E6F94D.7090706@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46764 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984Ab3ADRSO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jan 2013 12:18:14 -0500
In-Reply-To: <50E6F94D.7090706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

On Fri, 4 Jan 2013, Peter Ujfalusi wrote:

> On 01/04/2013 04:10 PM, Jon Hunter wrote:
> > 
> > On 01/04/2013 04:09 AM, Peter Ujfalusi wrote:
> >> To avoid issues with audio caused by non locked ABE DPLL we should
> >> make sure it is locked in all OMAP4 revisions.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >>
> >> asda d
> > 
> > Not sure what the above is ;-)
> 
> Argh, squashed patches without commit message cleanup...
> Paul: can you fix this up, or should I resend?

No worries, I'll fix it up here :-)


- Paul
