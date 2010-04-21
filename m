From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/1] i2c-omap: add mpu wake up latency constraint in
 i2c
Date: Wed, 21 Apr 2010 17:58:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1004211757410.24256@utopia.booyaka.com>
References: <1271876654-13613-1-git-send-email-khilman@deeprootsystems.com> <1271876654-13613-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35583 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab0DUX6I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 19:58:08 -0400
In-Reply-To: <1271876654-13613-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Wed, 21 Apr 2010, Kevin Hilman wrote:

> From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
> 
> While waiting for completion of the i2c transfer, the
> MPU could hit OFF mode and cause several msecs of
> delay that made i2c transfers fail more often. The
> extra delays and subsequent re-trys cause i2c clocks
> to be active more often. This has also an negative
> effect on power consumption.
> 
> Created a mechanism for passing and using the
> constraint setting function in driver code. The used
> mpu wake up latency constraints are now set individually
> per bus, and they are calculated based on clock rate
> and fifo size.
> 
> Thanks to Jarkko Nikula, Moiz Sonasath, Paul Walmsley,
> and Nishanth Menon for tuning out the details of
> this patch.
> 
> Cc: Moiz Sonasath <m-sonasath@ti.com>
> Cc: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
