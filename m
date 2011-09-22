From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/5 v11] arm: omap: usb: ehci and ohci hwmod structures
 for omap4
Date: Thu, 22 Sep 2011 17:35:21 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109221732140.10719@utopia.booyaka.com>
References: <1316691479-1849-1-git-send-email-keshava_mgowda@ti.com> <1316691479-1849-2-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54317 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074Ab1IVXfW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Sep 2011 19:35:22 -0400
In-Reply-To: <1316691479-1849-2-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, b-cousson@ti.com, balbi@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, khilman@ti.com, johnstul@us.ibm.com, vishwanath.bs@ti.com

Hi Keshava

so based on a closer look at how the EHCI/OHCI IP blocks are actually 
implemented on OMAP, they should not have hwmod entries associated with 
them.  Please take a look at 

http://marc.info/?l=linux-omap&m=131673433121673&w=2


- Paul
