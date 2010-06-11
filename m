From: "Nagarajan, Rajkumar" <x0133774@ti.com>
Subject: Alternative for defconfig
Date: Fri, 11 Jun 2010 17:49:45 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B6701706BD9A3A73@dbde02.ent.ti.com>
References: <201006091227.29175.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57166 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756184Ab0FKMTx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 08:19:53 -0400
In-Reply-To: <201006091227.29175.laurent.pinchart@ideasonboard.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

1. What is the alternative way of submitting defconfig changes/files to LO? 

2. Can any of you give me examples? 

Regards,
Rajkumar N.

> -----Original Message-----
> From: Laurent Pinchart [mailto:laurent.pinchart@ideasonboard.com] 
> Sent: Wednesday, June 09, 2010 3:57 PM
> To: Nagarajan, Rajkumar
> Cc: linux-media@vger.kernel.org
> Subject: Re: [PATCH] OMAP: V4L2: Enable V4L2 on ZOOM2/3 & 3630SDP
> 
> Hi Rajkumar,
> 
> On Wednesday 09 June 2010 11:51:45 Nagarajan, Rajkumar wrote:
> > Defconfig changes to enable V4L2 on zoom2, zoom3 and 3630sdp boards.
> 
> Defconfigs on ARM are going away. See the 
> http://lkml.org/lkml/2010/6/2/472 
> thread on LKML. There's also a lengthy discussion about that 
> on LAKML. Linus 
> will not accept any change to the defconfig files anymore and 
> currently plans 
> to remove them completely for 2.6.36.
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 