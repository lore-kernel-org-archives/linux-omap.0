From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v3 18/20] GPIO: OMAP: Use PM runtime framework
Date: Wed, 20 Jul 2011 15:16:22 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037C0C4D90@dbde02.ent.ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
 <1309513634-20971-19-git-send-email-tarun.kanti@ti.com>
 <4E2675AB.1070606@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037C0C4D7B@dbde02.ent.ti.com>
 <4E26A0DA.5040202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60817 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab1GTJq3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jul 2011 05:46:29 -0400
In-Reply-To: <4E26A0DA.5040202@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Quadros, Roger" <rogerq@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

[...]
> Let's say GPIO 1 and 2 belong to the same GPIO module.
> Driver A uses GPIO 1 and driver B uses GPIO 2.
> A is just blinking an LED every second whereas B uses GPIO 2 as input.
> 
> both drivers will keep the GPIOs requested as long as they are loaded.
> Why can't you turn off the clocks when nobody is accessing GPIO registers?
Ok, I get your point. I will have patch for off/retention mode support.
--
Tarun
> 
> In your current implementation, the GPIO module will never go idle.
> 
> cheers,
> -roger
