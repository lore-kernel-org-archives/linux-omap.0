From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: HSMMC: avoid erratum workaround when transceiver
 is attached
Date: Wed, 4 Apr 2012 08:31:31 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204040831220.8000@utopia.booyaka.com>
References: <1331902194-4679-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42856 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756311Ab2DDObc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Apr 2012 10:31:32 -0400
In-Reply-To: <1331902194-4679-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Fri, 16 Mar 2012, Grazvydas Ignotas wrote:

> If transceiver is attached to a MMC host of ES2.1 OMAP, it seems
> 2.1.1.128 erratum doesn't apply and there is no data corruption,
> probably because of different signal timing. The workaround for this
> erratum disables multiblock reads, which causes dramatic loss of
> performance (over 75% slower), so avoid it when transceiver is present.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

Thanks, queued for 3.4-rc.

- Paul
