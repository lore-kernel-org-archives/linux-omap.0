From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: no network on 3630/Zoom3 using omap3_defconfig
Date: Sat, 19 Jun 2010 03:01:22 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032358E85F@dbde02.ent.ti.com>
References: <87iq5hcjrc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47336 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989Ab0FRVbb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jun 2010 17:31:31 -0400
In-Reply-To: <87iq5hcjrc.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman wrote:
> Vishwa,
> 
> Can you have someone investigate/debug why using omap3_defconfig on
> 3630/Zoom3 results in no network while using omap_zoom3_defconfig
> seems to work?
> 
> In addition, this would also be a good opportunity to get rid of the
> Zoom3-specific defconfig and move towards using the common
> omap3_defconfig.
> 
> Kevin
> 

Works for me with a 3630SDP. I'll see if I can dig up a zoom3 and test
over the weekend.

- Anand
