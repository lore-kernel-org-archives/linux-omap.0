From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Prevent potential crash if GPMC probe
 fails
Date: Fri, 1 Feb 2013 14:08:04 -0800
Message-ID: <20130201220804.GZ22517@atomide.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com>
 <1359736726-10193-2-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52162 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757380Ab3BAWIG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 17:08:06 -0500
Content-Disposition: inline
In-Reply-To: <1359736726-10193-2-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Afzal Mohammed <afzal@ti.com>

* Jon Hunter <jon-hunter@ti.com> [130201 08:42]:
> If the GPMC probe fails, devices that use the GPMC (such as ethernet
> chips, flash memories, etc) can still allocate a GPMC chip-select and
> register the device. On the OMAP2420 H4 board, this was causing the
> kernel to crash after the gpmc probe failed and the board attempted
> to start networking. Prevent this by marking all the chip-selects as
> reserved by default and only make them available for devices to request
> if the GPMC probe succeeds.

Thanks applying into omap-for-v3.9/gpmc.

Regards,

Tony
