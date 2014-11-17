From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v8 0/8] can: c_can: Use syscon regmap for TI specific
 RAMINIT register
Date: Mon, 17 Nov 2014 14:07:37 +0200
Message-ID: <5469E509.3000700@ti.com>
References: <1415988591-6032-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37137 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbaKQMHu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Nov 2014 07:07:50 -0500
In-Reply-To: <1415988591-6032-1-git-send-email-mkl@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: wsa@the-dreams.de, linux-omap@vger.kernel.org, kernel@pengutronix.de

On 11/14/2014 08:09 PM, Marc Kleine-Budde wrote:
> Picking up Roger's work:
> 
> Changes since v7:
> - combined raminit start and done bit into a struct (3/8, 7/8, 8/8)
> - constified struct c_can_driver_data (2/8, 7/8, 8/8)
> - silenced compiler warning in c_can_hw_raminit_{wait,}_syscon (4/8)
> - use platform_get_device_id in probe() instead of open coding it (2/8)
> 

Thanks for saving me one more iteration :).
I've tested this to work on AM437x-evm and DRA7-evm.

Please pick patch 9 as well which I will send in response to this thread.
That one adds compatible id for am4372-d_can.

cheers,
-roger
