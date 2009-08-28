From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] Audio capture not working with AIC23/McBSP1 on
	OMAP3517
Date: Fri, 28 Aug 2009 13:05:19 +0100
Message-ID: <20090828120519.GA15915@opensource.wolfsonmicro.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9D82D@dbde02.ent.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0309E9DB24@dbde02.ent.ti.com> <20090827141253.9f772f31.jhnikula@gmail.com> <200908280955.01382.peter.ujfalusi@nokia.com> <20090828135103.63ca2343.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45631 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750948AbZH1MFS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Aug 2009 08:05:18 -0400
Content-Disposition: inline
In-Reply-To: <20090828135103.63ca2343.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Aug 28, 2009 at 01:51:03PM +0300, Jarkko Nikula wrote:

> Are you Mark fine with the patch [] where the snd_soc_dai_set_sysclk
> is used to specify source pin for CLKR and FSR?

Yes, that's OK.  Could you re-send the patch, I don't think I've got a
local copy any more?
