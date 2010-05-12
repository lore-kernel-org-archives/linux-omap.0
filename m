From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2 0/0] McBSP changes for OMAP4 platform
Date: Wed, 12 May 2010 10:07:57 +0100
Message-ID: <1273655277.3294.11.camel@odin>
References: <1273108546-2507-1-git-send-email-jorge.candelaria@ti.com>
	 <201005121139.26990.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:47995 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037Ab0ELJID (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 05:08:03 -0400
Received: by wwi18 with SMTP id 18so624213wwi.19
        for <linux-omap@vger.kernel.org>; Wed, 12 May 2010 02:08:00 -0700 (PDT)
In-Reply-To: <201005121139.26990.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: ext Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, tony@atomide.com, broonie@opensource.wolfsonmicro.com

On Wed, 2010-05-12 at 11:39 +0300, Peter Ujfalusi wrote:
> Hi,
> 
> On Thursday 06 May 2010 04:15:44 ext Jorge Eduardo Candelaria wrote:
> > The following patches enable McBSP driver to be used along with the
> > audio driver in SDP4430 and other OMAP4 based boards.
> > 
> > Changes from v1:
> > - Changed to correct IRQ lines.
> > - Check if rx_irq is defined, instead of checking if cpu is omap4
> > 
> > Jorge Eduardo Candelaria (2):
> >       ARM: McBSP: Fix request for irq in OMAP4
> >       ARM: OMAP4: Add support for omap4 in McBSP driver
> > 
> >  arch/arm/mach-omap2/mcbsp.c |   12 ++++--------
> >  arch/arm/plat-omap/mcbsp.c  |   34 +++++++++++++++++++---------------
> >  2 files changed, 23 insertions(+), 23 deletions(-)
> 
> Looks good with Jarkko's comment.
> However, I'd like to ask Tony, Liam, Jarkko, and Mark the following:
> Would it make sense to use the alsa tree for OMAP McBSP related patches, while 
> keeping l-o in CC off course.
> If we have patches for mcbsp pending in l-o and in alsa tree, than we are going 
> to have hard times to sort things out when they need to be merged.
> 
> I'm asking this, because I will also have some patches for mcbsp, which will 
> need change in arch/ and in sound/ as well.
> 
> I know that taking patches to alsa tree for the arch/ is unorthodox, but it will 
> ease up our life in a long run...
> 
> What do you think?

I tend to agree here since afaik audio is the primary upstream user of
mcbsp on OMAP. We do have queue of audio related mcbsp patches pending
atm and merging would be simpler in the ALSA tree atm.

Liam 

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

