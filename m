From: Nishanth Menon <nm@ti.com>
Subject: Re: Difference between twl4030_hsmmc_info and omap_mmc_platform_data
Date: Thu, 14 Oct 2010 18:23:31 -0500
Message-ID: <4CB790F3.3020204@ti.com>
References: <DB759C09-975B-4088-B334-79F9010573F8@mac.com> <4CB78AA1.40909@ti.com> <470C7B61-2724-4777-ADF2-341E61056008@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38479 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab0JNXXf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 19:23:35 -0400
In-Reply-To: <470C7B61-2724-4777-ADF2-341E61056008@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "omapandroid-discussion@omapzoom.org" <omapandroid-discussion@omapzoom.org>

Elvis Dowson had written, on 10/14/2010 06:18 PM, the following:
> Hi,
> 
> On Oct 15, 2010, at 2:56 AM, Nishanth Menon wrote:
>> mainline does it this way:
>> board files report using omap2_hsmmc_info[2] to hsmmc.c using omap2_hsmmc_init[3] - hsmmc.c
 >> converts them to required datastructures that omap_hsmmc.c uses..
> 
> What is the relationship between twl4030 and hsmmc controller in this chain,
> especially with respect to MMC2? 
As far as I know, card detection and power supply.

-- 
Regards,
Nishanth Menon
