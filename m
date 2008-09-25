From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [PATCH 0/9] HDQ driver fixes
Date: Thu, 25 Sep 2008 12:05:21 +0530
Message-ID: <023c01c91ed8$e4422880$LocalHost@wipultra1303>
References: <42568.192.168.10.89.1222255148.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41881 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbYIYGgh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 02:36:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: johnpol@2ka.mipt.ru, felipe.balbi@nokia.com, linux-omap@vger.kernel.org, "Gadiyar, Anand" <gadiyar@ti.com>

Hi Tony,

Somehow the mailer I am using seem to wrap the patch header and I dont have a immediate fix for the same.So Anand will repost the same patches again on behalf of me.I added one more patch to the series which fixed some minor comments that came in after I posted the patches.

Regards,
Madhu
----- Original Message ----- 
From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
To: <tony@atomide.com>
Cc: <johnpol@2ka.mipt.ru>; <felipe.balbi@nokia.com>; <linux-omap@vger.kernel.org>
Sent: Wednesday, September 24, 2008 4:49 PM
Subject: [PATCH 0/9] HDQ driver fixes


> Hi Tony,
> 
> I am posting a series of nine patches for the HDQ driver. The patch series
> provides cleanup of the driver pointed out by Filipe's diff file, use ioremap
> for HDQ base, replace usage of semaphore with mutex, fixes some commenting
> style and indentation.
> 
> Regards,
> Madhu
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
>
