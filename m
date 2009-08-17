From: "Hemanth V" <hemanthv@ti.com>
Subject: Re:  Zoom2 Support on LO Master broken ?
Date: Mon, 17 Aug 2009 17:54:34 +0530
Message-ID: <008201ca1f35$ae17bf00$LocalHost@wipultra793>
References: <007301ca1f34$df482c50$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43705 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbZHQMYk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Aug 2009 08:24:40 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7HCOZ9e017864
	for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2009 07:24:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>, linux-omap@vger.kernel.org

----- Original Message ----- 
From: "Hemanth V" <hemanthv@ti.com>
To: <linux-omap@vger.kernel.org>
Sent: Monday, August 17, 2009 5:48 PM
Subject: Zoom2 Support on LO Master broken ?


>I am unable to boot from quad uart and if I try uart3 I get the below error

For quad uart it stops after downloading kernel (ZOOM2 defconfig), probably 
related to LL_DEBUG setting.

>
> <3>IP-Config: No network devices available.
> IP-Config: No network devices available.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> 

