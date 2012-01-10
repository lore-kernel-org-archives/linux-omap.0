From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHV2 REPOST 3/7] ARM: OMAP4 PM: Add IO Daisychain support
Date: Tue, 10 Jan 2012 09:35:21 -0800
Message-ID: <87ipkjsbom.fsf@ti.com>
References: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
	<1323878477-21122-4-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:34949 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932347Ab2AJRfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 12:35:24 -0500
Received: by yenq7 with SMTP id q7so1192476yen.7
        for <linux-omap@vger.kernel.org>; Tue, 10 Jan 2012 09:35:23 -0800 (PST)
In-Reply-To: <1323878477-21122-4-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Wed, 14 Dec 2011 21:31:13 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Vishwanath BS <vishwanath.bs@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> patch adds IO Daisychain support for OMAP4 as per section 3.9.4 in OMAP4430
> Public TRM.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Tested-by: Govindraj.R <govindraj.raja@ti.com>

One of my least favorite things to have to remind others to do, but:

Please fix checkpatch warnings:

WARNING: line over 80 characters
#43: FILE: arch/arm/mach-omap2/prm44xx.c:158:
+	if (!(omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET)

WARNING: line over 80 characters
#46: FILE: arch/arm/mach-omap2/prm44xx.c:161:
+				OMAP4430_GLOBAL_WUEN_MASK, OMAP4430_PRM_DEVICE_INST,

WARNING: line over 80 characters
#50: FILE: arch/arm/mach-omap2/prm44xx.c:165:
+	omap4_prm_rmw_inst_reg_bits(OMAP4430_WUCLK_CTRL_MASK, OMAP4430_WUCLK_CTRL_MASK,

WARNING: line over 80 characters
#53: FILE: arch/arm/mach-omap2/prm44xx.c:168:
+		((omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST, OMAP4_PRM_IO_PMCTRL_OFFSET)

