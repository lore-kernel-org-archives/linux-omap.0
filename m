From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] OMAP: McBSP: Fix static function warning
Date: Wed, 8 Sep 2010 10:13:30 +0100
Message-ID: <20100908091330.GC31253@rakim.wolfsonmicro.main>
References: <1283916223-23567-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58896 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752714Ab0IHJNc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 05:13:32 -0400
Content-Disposition: inline
In-Reply-To: <1283916223-23567-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

On Wed, Sep 08, 2010 at 08:53:43AM +0530, G, Manjunath Kondaiah wrote:
> This patch fixes sparse warning due non declaration of static function
> 
> sound/soc/omap/omap-mcbsp.c:783:5: warning: symbol 'omap_mcbsp_st_info_volsw' was not declared. Should it be static?

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
