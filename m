From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/5] [htcherald] Add board support for UARTs, bluetooth
Date: Wed, 4 Aug 2010 13:16:15 +0300
Message-ID: <20100804101614.GH9881@atomide.com>
References: <1280762976-17284-1-git-send-email-darkstar6262@gmail.com>
 <1280762976-17284-6-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58169 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932201Ab0HDKPq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 06:15:46 -0400
Content-Disposition: inline
In-Reply-To: <1280762976-17284-6-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Cory Maccarrone <darkstar6262@gmail.com> [100802 18:23]:
> This change adds bluetooth and UART initialization support to the
> HTC Herald board driver.  This allows use of the serial bluetooth
> adapter attached to UART1 using hciattach.

Ah and here you already have the gpio pins in platform_data, nice.
Still, the driver part should be under drivers in the previous patch.

Regards,

Tony
