From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv8 3/5] OMAP: I2C: Reset support
Date: Fri, 16 Dec 2011 01:38:54 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160138310.12660@utopia.booyaka.com>
References: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com> <1323773758-6375-4-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40878 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab1LPIiz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 03:38:55 -0500
In-Reply-To: <1323773758-6375-4-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, b-cousson@ti.com, ben-linux@fluff.org

On Tue, 13 Dec 2011, Shubhrajyoti D wrote:

> Under some error conditions the i2c driver may do a reset.
> Adding a reset field and support in the device-specific code to aid
> error-recovery.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Thanks, queued for 3.3.


- Paul
