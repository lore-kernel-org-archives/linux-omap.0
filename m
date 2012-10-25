From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Thu, 25 Oct 2012 11:43:40 +0200
Message-ID: <508909CC.9000000@gmail.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com> <1350935758-9215-5-git-send-email-zonque@gmail.com> <50889BB2.3090107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60223 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934884Ab2JYJno (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 05:43:44 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so631978bkc.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 02:43:42 -0700 (PDT)
In-Reply-To: <50889BB2.3090107@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com

Hi Jon,

On 25.10.2012 03:53, Jon Hunter wrote:
> 
> On 10/22/2012 02:55 PM, Daniel Mack wrote:

>> +Example for an AM33xx board:
>> +
>> +	gpmc: gpmc@50000000 {
>> +		compatible = "ti,gpmc";
>> +		ti,hwmods = "gpmc";
>> +		reg = <0x50000000 0x1000000>;
> 
> Nit-pick, that size is quite large for a register range. I recommend
> looking at the HWMOD data file
> (arch/arm/mach-omap2/omap_hwmod_33xx_data.c) and see how much space is
> allocated for the registers (see structure am33xx_gpmc_addr_space).

Yeah but reserving the entire memory as per the reference manual also
prvents other from poking around in the same register space. Is there a
scenario in which it would of disadvantage to reserve all that memory?



Daniel


