From: Peter Barada <peter.barada@gmail.com>
Subject: cpufreq-info doesn't work in linux-3.0 on DM3730
Date: Sat, 01 Oct 2011 13:32:19 -0400
Message-ID: <4E874EA3.6060903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58532 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab1JARbL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Oct 2011 13:31:11 -0400
Received: by gyg10 with SMTP id 10so2355457gyg.19
        for <linux-omap@vger.kernel.org>; Sat, 01 Oct 2011 10:31:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm trying to get frequency scaling working in linux-3.0, and it after 
digging into why cpufreq-info works in 2.6.32 and doesn't in 3.0, I've 
found that omap_cpu_init() returs -ENOENT due to clk_get(NULL, 
"virt_prcm_set") failing.

In the older 2.6.32 kernel it used "arm_fck" for MPU_CLK instead of 
"virt_prcm_set", but that option isn't in the linux-3.0 source (or the 
current source in tony's tree on github.com).  I tried reverting to 
"arm_fck", but on a DM3730 cpupfreq-info only shows 600Mhz as a 
possibility, and none of the other operating points.

Does anyone have CPU frequency scaling working in linux-3.0 and have any 
suggestions on what I'm doing wrong?

-- 
Peter Barada
peter.barada@gmail.com

