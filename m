From: Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH v3 03/04] ARM: OMAP: Rename twl4030_ in rtc-twl.c to
 make it generic rtc
Date: Wed, 18 Nov 2009 15:42:52 +0100
Message-ID: <20091118154252.55b97822@linux.lan.towertech.it>
References: <1254399633-3691-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from elettra.colt-to.towertech.it ([213.215.222.70]:56111 "EHLO
	elettra.colt-to.towertech.it" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754822AbZKROxH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Nov 2009 09:53:07 -0500
In-Reply-To: <1254399633-3691-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap@vger.kernel.org, sameo@linux.intel.com, wim@iguana.be, timo.t.kokkonen@nokia.com, ben-linux@fluff.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, p_gortmaker@yahoo.com, rtc-linux@googlegroups.com, Balaji T K <balajitk@ti.com>, Nayak Rajendra <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Thu,  1 Oct 2009 17:50:33 +0530
balajitk@ti.com wrote:

> From: Balaji T K <balajitk@ti.com>
> 
>  This patch renames all twl4030_ functions to twl_ so that RTC driver can be
>  shared between Triton and Phoenix.  

 Which tree should handle that? The two patches you sent involves
 both mfd and rtc and I don't have that mfd/twl.. in my tree.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

