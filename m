From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] ARM: omap5: hwmod_data: Correct IDLEMODE for McPDM
Date: Wed, 14 May 2014 17:13:58 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1405141713430.21921@utopia.booyaka.com>
References: <alpine.DEB.2.02.1405081602220.23579@utopia.booyaka.com> <1399623005-30581-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:45294 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756548AbaENRN7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 13:13:59 -0400
In-Reply-To: <1399623005-30581-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com

On Fri, 9 May 2014, Peter Ujfalusi wrote:

> McPDM need to be configured to NO_IDLE mode when it is in used otherwise
> vital clocks will be gated which results 'slow motion' audio playback.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks, queued for v3.15-rc.

- Paul
