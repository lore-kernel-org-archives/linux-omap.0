From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 1/5] OMAP4: hwmod: Add names for DMIC memory address
 space
Date: Wed, 25 Jan 2012 14:23:13 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201251423030.5324@utopia.booyaka.com>
References: <1322487943-14280-1-git-send-email-peter.ujfalusi@ti.com> <1322487943-14280-2-git-send-email-peter.ujfalusi@ti.com> <alpine.DEB.2.00.1112152327410.12660@utopia.booyaka.com> <4EEB5913.3090901@ti.com> <alpine.DEB.2.00.1112191451140.12660@utopia.booyaka.com>
 <4F1D4A03.3050700@ti.com> <alpine.DEB.2.00.1201240134421.29673@utopia.booyaka.com> <4F1E8186.2060307@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47295 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295Ab2AYVXO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 16:23:14 -0500
In-Reply-To: <4F1E8186.2060307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Tue, 24 Jan 2012, Peter Ujfalusi wrote:

> On 01/24/2012 10:36 AM, Paul Walmsley wrote:
> >> This patch seams to be missing from 3.3-rc1. The rest of the series is
> >> there, but because of the missing patch audio does not probe on
> >> 4430SDP/Blaze.
> >> Can you queue this as a fix for Linus?
> > 
> > Doh, not sure what happened here.  A brief triage question.  Did audio 
> > probe correctly on 4430SDP/Blaze on 3.2?
> 
> Yes, it did.
> I have added the DMIC support for 3.3. Without this patch the DMIC
> driver is not probing (can't get the resources) which prevents the audio
> to work (the DMIC dai is missing, so the card does not come up).

Okay, thanks, queued for 3.3-rc.


- Paul
