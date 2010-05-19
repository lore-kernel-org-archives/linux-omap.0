From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCH 2/4] OMAP: mcbsp - add smart idle
 configuration API
Date: Wed, 19 May 2010 12:21:26 +0100
Message-ID: <1274268086.3240.136.camel@odin>
References: <1274213594-26554-1-git-send-email-lrg@slimlogic.co.uk>
	 <1274213594-26554-3-git-send-email-lrg@slimlogic.co.uk>
	 <20100519104628.GJ4265@besouro.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:59709 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab0ESLVc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 07:21:32 -0400
Received: by wwb22 with SMTP id 22so488304wwb.19
        for <linux-omap@vger.kernel.org>; Wed, 19 May 2010 04:21:31 -0700 (PDT)
In-Reply-To: <20100519104628.GJ4265@besouro.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: eduardo.valentin@nokia.com
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2010-05-19 at 13:46 +0300, Eduardo Valentin wrote:
> Hello Lian,
> 
> On Tue, May 18, 2010 at 10:13:12PM +0200, Liam Girdwood wrote:
> > Add a small API to configure McBSP smart idle modes
> > to conserve power.
> 
> I'm sorry but I didn't get the point of this patch, as you didn't add any wider
> description why you need to export this feature. 

Sorry, I thought this would obvious from the patch and description.

> Why do you think mcbsp clients
> should be aware of these bit? Would it make sense to mask it behind other feature?
> like the threshold size for instance..

Why do you think it should be masked behind threshold ? 

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

