From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCHv2 2/5] ASoC: core: soc level wrapper for
 pcm_pointer callback
Date: Wed, 03 Mar 2010 13:27:42 +0000
Message-ID: <1267622862.3185.1.camel@odin>
References: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
	 <1267621689-30337-4-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:50984 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab0CCN1q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 08:27:46 -0500
Received: by ey-out-2122.google.com with SMTP id 25so239315eya.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Mar 2010 05:27:45 -0800 (PST)
In-Reply-To: <1267621689-30337-4-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: broonie@opensource.wolfsonmicro.com, tony@atomide.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, ext-eero.nurkkala@nokia.com

On Wed, 2010-03-03 at 15:08 +0200, Peter Ujfalusi wrote:
> Create a soc level wrapper for pcm_pointer callback.
> This will facilitate the soc level handling of different
> HW buffers in the audio path.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

