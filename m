From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/4] McBSP smart idle and DMA op mode updates for ASoC
Date: Wed, 19 May 2010 12:07:11 +0100
Message-ID: <1274267231.3240.117.camel@odin>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
	 <20100519104209.GI4265@besouro.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41810 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757029Ab0ESLHR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 07:07:17 -0400
Received: by wyg36 with SMTP id 36so316863wyg.19
        for <linux-omap@vger.kernel.org>; Wed, 19 May 2010 04:07:16 -0700 (PDT)
In-Reply-To: <20100519104209.GI4265@besouro.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eduardo.valentin@nokia.com
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>

On Wed, 2010-05-19 at 13:42 +0300, Eduardo Valentin wrote:
> On Tue, May 18, 2010 at 10:13:10PM +0200, Liam Girdwood wrote:
> > This series expands the OMAP mcbsp driver to support changing it's DMA operating
> > mode and smart idle mode from client drivers. It's primarily aimed at lowering
> > the power consumption for OMAP ASoC drivers by providing methods to gate clocks
> > on the mcbsp interface at runtime.
> > 
> > I've also added a patch to remove the mcbsp DMA op mode sysfs set functionality.
> > I think DMA op mode is very specific to the mcbsp client driver _only_ and
> > shouldn't really be changed by userspace. Please let me know if you use this
> > feature and I'll drop this patch.
> 
> Yeah, I'm not sure if that would be strong enough argument though. Unfortunately,
> this dma op mode also couples with the usage of mcbsp internal buffer. Which in the very
> end will mean a compromise between delay vs. pm, as you are probably aware.
> 
> So, letting userspace to toggle this mode will also mean they can choose between pm friendly
> (op mode with frame and so on) or short delay friendly (element mode).
> 
> Of course, this might not be the best way of choosing it though.
> 

The sysfs set interface implies userspace having knowledge of driver
capabilities and configuration in order to safely toggle between the two
DMA modes. Imo, the mcbsp client driver should be the only entity
configuring it's DMA modes (in a safe manner) depending on the use case.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

