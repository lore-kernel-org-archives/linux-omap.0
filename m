From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: DTS: am335x-evmsk: Enable the McASP FIFO for
 audio
Date: Mon, 7 Jul 2014 04:35:16 -0700
Message-ID: <20140707113516.GR28884@atomide.com>
References: <1404381083-27029-1-git-send-email-peter.ujfalusi@ti.com>
 <1404381083-27029-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26439 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbaGGLfO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2014 07:35:14 -0400
Content-Disposition: inline
In-Reply-To: <1404381083-27029-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [140703 02:53]:
> The use of FIFO in McASP can reduce the risk of audio under/overrun and
> lowers the load on the memories since the DMA will operate in bursts.

Applying both into omap-for-v3.16/fixes thanks.

Tony
