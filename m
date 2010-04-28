From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH v2] generic clk module removal
Date: Tue, 27 Apr 2010 20:34:57 -0500
Message-ID: <4BD790C1.6030406@gmail.com>
References: <1272418167-12630-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.211.194]:45561 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673Ab0D1BfD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 21:35:03 -0400
Received: by ywh32 with SMTP id 32so8146186ywh.33
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 18:35:01 -0700 (PDT)
In-Reply-To: <1272418167-12630-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>

On 04/27/2010 08:29 PM, Omar Ramirez Luna wrote:
> This set of patches remove clk module from the services layer.
>
> Now:
> - GPT 5-8 are controlled through DM Timer framework.
> - MCBSP clocks are enabled by requesting the proper mcbsp device.
> - WDT is left for bridge driver to control rather than on request from dsp.
> - SSI is controlled by enabling/disabling its sst, ssr and ick clocks.
>
> v2:
> - rebased
> - keep iva2 handling as it is advised to turn off the clocks for iva reset
>    sources.
> - release all the clocks (disable&  free) if driver is uninstalled.
>
>
> Omar Ramirez Luna (5):
>    DSPBRIDGE: iva2 clock handling
>    DSPBRIDGE: dsp interface to enable ssi clocks
>    DSPBRIDGE: Balance the number of enable/disable
>    DSPBRIDGE: move clk to dsp-clock
>    DSPBRIDGE: reorganize the code to handle peripheral clocks
>    DSPBRIDGE: remove clk_handle from drv interface
>    DSPBRIDGE: fail if clk handle is NULL
>    DSPBRIDGE: Now actually fail if a clk handle is wrong
>    DSPBRIDGE: Rename services_clk_* to dsp_clk_*
>    DSPBRIDGE: remove unused clock sys_ck
>    DSPBRIDGE: remove function clk_set32k_hz
>    DSPBRIDGE: remove clk_get_use_cnt
>    DSPBRIDGE: trivial clock cleanup for unused code
>    DSPBRIDGE: function to get the type of clock requested by dsp
>    DSPBRIDGE: use dm timer framework for gpt timers
>    DSPBRIDGE: use omap mcbsp to enable mcbsp clocks
>    DSPBRIDGE: remove wdt3 from dsp control
>    DSPBRIDGE: use one call for both ick and fck clocks
>    DSPBRIDGE: Move MCBSP_CLOCKS code to a common place
is there a series numbering for this patchset?
Regards,
Nishanth Menon
