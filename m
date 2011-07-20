From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v3 18/20] GPIO: OMAP: Use PM runtime framework
Date: Wed, 20 Jul 2011 14:58:17 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037C0C4D7B@dbde02.ent.ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
 <1309513634-20971-19-git-send-email-tarun.kanti@ti.com>
 <4E2675AB.1070606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37640 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab1GTJ2X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jul 2011 05:28:23 -0400
In-Reply-To: <4E2675AB.1070606@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Quadros, Roger" <rogerq@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

[...]
>  From this patch it seems that the GPIO module is kept active as long as
> one of its GPIOs is requested. This is not optimal.
Yes, but...

> 
> The GPIO needs to be active only when accessing its registers e.g.
> during gpio_get or gpio_set. The rest of the time it can be suspended.
A GPIO module would typically be used by multiple client drivers.
However, the clock control is common for all GPIO pins within the module.
So clocks can't be turned-off/on without negatively impacting present users.
Instead, client drivers have to ensure that they free GPIO pin(s) after use.
This would make power savings optimal.
--
Tarun

> 
> cheers,
> -roger
[...]
