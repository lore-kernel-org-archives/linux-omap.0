From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] arm: omap2: fix AM33xx hwmod infos for UART2
Date: Mon, 3 Jun 2013 09:24:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306030924130.4635@utopia.booyaka.com>
References: <1369754265-27712-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:33880 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab3FCJYa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jun 2013 05:24:30 -0400
In-Reply-To: <1369754265-27712-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hiremath Vaibhav <hvaibhav@ti.com>

On Tue, 28 May 2013, Thomas Petazzoni wrote:

> The UART2 hwmod structure is pointing to the EDMA channels of UART1,
> which doesn't look right. This patch fixes this by making the UART2
> hwmod structure to a new structure that lists the EDMA channels to be
> used by the UART2.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks Thomas, queued with Vaibhav's ack.


- Paul
