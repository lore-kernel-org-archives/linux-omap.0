From: Tom Cooksey <thomas.cooksey@trolltech.com>
Subject: Re: tslib on OMAP3
Date: Thu, 26 Jun 2008 10:04:09 +0200
Message-ID: <200806261004.10138.thomas.cooksey@trolltech.com>
References: <200806251833.25218.thomas.cooksey@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hoat.troll.no ([62.70.27.150]:60260 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbYFZIER (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jun 2008 04:04:17 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id F29212045C
	for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2008 10:04:11 +0200 (CEST)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id E87622038E
	for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2008 10:04:11 +0200 (CEST)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id m5Q84BA6005717
	for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2008 10:04:11 +0200
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301118F2D6E@dbde02.ent.ti.com>
References: <2ee9e08d0806250948pbc33b01k9bccd66fe3131e4f@mail.gmail.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301118F2D6E@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 26 June 2008 09:03:09 Premi, Sanjeev wrote:
> Hi Tom,
> 
> The tslib is contained OMAP35x package released from Texas Instruments. It is functional.
> This package is based on 2.6.22-18.
> 
> What is the kernel version you are using?
> Are you may want to look to update the touchscreen driver (drivers/input/touchscreen/ads7846.c).

I'm using a binary blob kernel, directly from TI. I can't change kernel
as I'm using the PowerVR SGX drivers, which I don't have the source 
for. :-(

I'l ask TI for an updated kernel, if you believe this to be the problem. I
was assuming it was a tslib module/configuration problem.




Cheers,

Tom
