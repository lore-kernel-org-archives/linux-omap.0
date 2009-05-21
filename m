From: "Gupta, Ramesh" <grgupta@ti.com>
Subject: RE: [PATCH] OMAP: clock: export notifier register functions
Date: Thu, 21 May 2009 12:08:04 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B4A846E9@dbde02.ent.ti.com>
References: <1242886726-19761-1-git-send-email-x00omar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46317 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130AbZEUGiQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 May 2009 02:38:16 -0400
In-Reply-To: <1242886726-19761-1-git-send-email-x00omar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi Omar,
 

> -----Original Message-----
> From: Ramirez Luna, Omar 
> Sent: Thursday, May 21, 2009 11:49 AM
> To: Kevin Hilman; Tony Lindgren
> Cc: linux-omap; Gupta, Ramesh
> Subject: [PATCH] OMAP: clock: export notifier register functions
> 
> From: Gupta, Ramesh <grgupta@ti.com>
> 
> Hi,
> 
> The following patch is required to export some symbols to be 
> used by bridge driver, it was merged in 2.6.28 but seems like 
> it was dropped for later kernels, is it ok to put it back in 
> for linux-omap-pm 2.6.29 and/or linux-omap master?

There are some more updated patches available for the clock notifier 
Register functions([1] & [2]).
 
We need to call these functions from platform_data , export is not really
Required.[3].


Ref[1]: http://marc.info/?l=linux-omap&m=123755561914202&w=2
Ref[2]: http://marc.info/?l=linux-omap&m=123755561914205&w=2


Ref[3]: http://marc.info/?l=linux-omap&m=123788690904660&w=2

Please let me know if you see any issues.

Regards
Ramesh Gupta G