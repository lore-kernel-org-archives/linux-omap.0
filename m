From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v3 03/04] ARM: OMAP: Rename twl4030_ in rtc-twl.c to
 make it generic rtc
Date: Sun, 13 Dec 2009 21:28:27 +0100
Message-ID: <20091213202826.GB10094@sortiz.org>
References: <1254399633-3691-1-git-send-email-balajitk@ti.com>
 <20091118154252.55b97822@linux.lan.towertech.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:13680 "HELO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752052AbZLMU0y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Dec 2009 15:26:54 -0500
Content-Disposition: inline
In-Reply-To: <20091118154252.55b97822@linux.lan.towertech.it>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: balajitk@ti.com, linux-omap@vger.kernel.org, wim@iguana.be, timo.t.kokkonen@nokia.com, ben-linux@fluff.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, p_gortmaker@yahoo.com, rtc-linux@googlegroups.com, Nayak Rajendra <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Alessandro,

On Wed, Nov 18, 2009 at 03:42:52PM +0100, Alessandro Zummo wrote:
> On Thu,  1 Oct 2009 17:50:33 +0530
> balajitk@ti.com wrote:
> 
> > From: Balaji T K <balajitk@ti.com>
> > 
> >  This patch renames all twl4030_ functions to twl_ so that RTC driver can be
> >  shared between Triton and Phoenix.  
> 
>  Which tree should handle that? The two patches you sent involves
>  both mfd and rtc and I don't have that mfd/twl.. in my tree.
I'm taking this patch through the mfd tree, thanks.

Cheers,
Samuel.


> -- 
> 
>  Best regards,
> 
>  Alessandro Zummo,
>   Tower Technologies - Torino, Italy
> 
>   http://www.towertech.it
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
