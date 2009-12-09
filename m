From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: RE: [PATCH v3 0/4] TWL patch series
Date: Wed, 9 Dec 2009 11:09:33 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940437210696@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E73940436CF8BF5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53878 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbZLIFjk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 00:39:40 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436CF8BF5@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "sameo@linux.intel.com" <sameo@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "p_gortmaker@yahoo.com" <p_gortmaker@yahoo.com>, "tony@atomide.com" <tony@atomide.com>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

Hi Samuel,

This patch is not merged. Please let me know if I am missing something
so that i can post the patches rebased on the latest 2.6.32.

Thanks and Regards,
Balaji T K

> -----Original Message-----
> From: Krishnamoorthy, Balaji T
> Sent: Thursday, October 01, 2009 5:35 PM
> To: linux-omap@vger.kernel.org
> Cc: Krishnamoorthy, Balaji T; Shilimkar, Santosh; Nayak, Rajendra;
> a.zummo@towertech.it; p_gortmaker@yahoo.com; sameo@linux.intel.com;
> tony@atomide.com
> Subject: [PATCH v3 0/4] TWL patch series
> 
> This patch series v3 incorporates comments received earlier[1].
> 
> The upcoming TWL6030 is companion chip for OMAP4 like the current TWL4030
> for OMAP3. The common modules like RTC, Regulator creates opportunity
> to re-use the most of the code from twl4030.
> 
> 	[PATCH v3 01/04] ARM: OMAP: Rename twl4030* driver files to enable re-
> use
> 	[PATCH v3 02/04] ARM: OMAP: Rename all twl4030_i2c*.
> 	[PATCH v3 03/04] ARM: OMAP: Rename twl4030_ in rtc-twl.c to make it
> 				generic rtc
> 	[PATCH v3 04/04] ARM: OMAP: Rename twl4030_ to twl_ in twl-regulator.c
> to
> 				make it generic reg
> 
> [1] http://marc.info/?l=linux-omap&m=124757921417187&w=2
>   [PATCH 0/4] TWL patch series
