From: Liam Girdwood <lrg@ti.com>
Subject: Re: [RFC 04/11] ASoC: core - Add API call to register dai kcontrols.
Date: Wed, 15 Feb 2012 15:46:21 +0000
Message-ID: <1329320781.14552.1.camel@odin>
References: <1329320280-1621-1-git-send-email-peter.ujfalusi@ti.com>
	 <1329320280-1621-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:40121 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751830Ab2BOPqc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 10:46:32 -0500
Received: by mail-we0-f179.google.com with SMTP id a1so780918wer.38
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 07:46:24 -0800 (PST)
In-Reply-To: <1329320280-1621-5-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>

On Wed, 2012-02-15 at 17:37 +0200, Peter Ujfalusi wrote:
> Allow dai drivers to register kcontrols.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  include/sound/soc.h  |    2 ++
>  sound/soc/soc-core.c |   31 +++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 0 deletions(-)

This feature has already been applied.

Regards

Liam

