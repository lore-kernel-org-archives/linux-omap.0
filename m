From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/4] OMAP: mcbsp - add omap_mcbsp_set_dma_op_mode()
Date: Wed, 19 May 2010 12:30:36 +0100
Message-ID: <1274268636.3240.146.camel@odin>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
	 <1274213594-26554-2-git-send-email-lrg@slimlogic.co.uk>
	 <20100519105056.GK4265@besouro.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45636 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569Ab0ESLan (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 07:30:43 -0400
Received: by wyg36 with SMTP id 36so331413wyg.19
        for <linux-omap@vger.kernel.org>; Wed, 19 May 2010 04:30:40 -0700 (PDT)
In-Reply-To: <20100519105056.GK4265@besouro.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eduardo.valentin@nokia.com
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>

On Wed, 2010-05-19 at 13:50 +0300, Eduardo Valentin wrote:
> On Tue, May 18, 2010 at 10:13:11PM +0200, Liam Girdwood wrote:
> > This adds a method to set the MCBSP DMA OP mode.
> 
> OK. good. But again, why do you need set dma op mode other than inside mcbsp code?
> 

I think Peter has answered this.

> Right, so, from what I have read briefly, the idea is to remove the user space ability to set the mode and
> let mcbsp clients to do it. What is not clear to me is how mcbsp clients (inside kernel) will determine if they want
> short delay or pm friendly. That usually is bound to upper use case though.
> 

An example would be an ASoC client. The ASoC driver would be configured
either for low latency, low power, etc. by userspace (using formal ALSA
calls) and would be able to configure the mcbsp to match this request.  


> It would be really nice if you improve your patch descriptions.

Sorry, I thought again this was obvious.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

