From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH v2 2/3] ARM/ASoC: OMAP McBSP: Move remainig defines from
 arch to ASoC header
Date: Thu, 08 Mar 2012 11:37:31 +0200
Message-ID: <4F587DDB.5080202@bitmer.com>
References: <1331198537-13469-1-git-send-email-peter.ujfalusi@ti.com> <1331198537-13469-3-git-send-email-peter.ujfalusi@ti.com> <4F587C00.1090307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:33990 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755961Ab2CHJhV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Mar 2012 04:37:21 -0500
In-Reply-To: <4F587C00.1090307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 03/08/2012 11:29 AM, Peter Ujfalusi wrote:
> Hi Jarkko,
> 
> On 03/08/2012 11:22 AM, Peter Ujfalusi wrote:
>> Clock signal muxing, and functional clock related defines are only needed
>> in ASoC drivers.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> 
> I have added your ack to this patch by accident when I updated the
> series. Sorry about that.
> Please confirm if you are OK with this change.
> 
Go ahead :-)

-- 
Jarkko
