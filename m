From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] omap v4l2: fix wrong resizer calculation
Date: Wed, 15 Jun 2011 20:06:32 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404E307228C@dbde02.ent.ti.com>
References: <4DB67614.7030008@gmail.com> <4DF8865F.5010007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44134 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754966Ab1FOOgh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jun 2011 10:36:37 -0400
In-Reply-To: <4DF8865F.5010007@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vladimir Pantelic <vladoman@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Vladimir Pantelic [mailto:vladoman@gmail.com]
> Sent: Wednesday, June 15, 2011 3:46 PM
> To: Kernel development list
> Cc: linux-omap@vger.kernel.org; Hiremath, Vaibhav
> Subject: Re: [PATCH] omap v4l2: fix wrong resizer calculation
> 
> ping
[Hiremath, Vaibhav] Sorry for delayed response, somehow I completely missed this patch.

Thanks for finding this bug, the patch looks ok to me. Only one suggestion I have is to update the description of patch commit, request you to change like following - 

----
The omap_vout_new_crop() function has possible bug, uses uninitialized
variable "crop.width/height" which is actually output of the function. 
Instead we should be using "try_crop.width/height" to calculate the resizer value.
----

Rest everything looks ok, while submitting patch again you can add my ack; I will queue to my Arago repo.

Also I have tested this patch on OMAP3EVM platform, and it seems to be working fine.

Thanks,
Vaibhav

