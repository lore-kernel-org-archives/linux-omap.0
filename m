From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP: omap_device: Correct resource handling
 for DT boot
Date: Sat, 03 Nov 2012 09:31:04 +0100
Message-ID: <5094D648.80608@deeprootsystems.com>
References: <1351596296-13825-1-git-send-email-peter.ujfalusi@ti.com> <1351596296-13825-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:48901 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab2KCLuo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 07:50:44 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so1966691wey.19
        for <linux-omap@vger.kernel.org>; Sat, 03 Nov 2012 04:50:44 -0700 (PDT)
In-Reply-To: <1351596296-13825-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 10/30/2012 12:24 PM, Peter Ujfalusi wrote:
> When booting with DT the OF core can fill up the resources provided within
> the DT blob.
> The current way of handling the DT boot prevents us from removing hwmod data
> for platforms only suppose to boot with DT (OMAP5 for example) since we need
> to keep the whole hwmod database intact in order to have more resources in
> hwmod than in DT (to be able to append the DMA resource from hwmod).
>
> To fix this issue we just examine the OF provided resources:
> If we do not have resources we use hwmod to fill them.
> If we have resources we check if we already able to recive DMA resource, if
> no we only append the DMA resurce from hwmod to the OF provided ones.
>
> In this way we can start removing hwmod data for devices which have their
> resources correctly configured in DT without regressions.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>ke

Acked-by: Kevin Hilman <khilman@ti.com>

Benoit, feel free to take this one as well.

Kevin

