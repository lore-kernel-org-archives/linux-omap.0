From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP* Latest build failures
Date: Wed, 28 Nov 2012 15:16:08 +0000
Message-ID: <20121128151608.GY3332@n2100.arm.linux.org.uk>
References: <20121114092643.GG3290@n2100.arm.linux.org.uk> <20121117093307.GL3332@n2100.arm.linux.org.uk> <20121120175733.GH18567@atomide.com> <50B619F1.3000207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51900 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238Ab2K1PVY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Nov 2012 10:21:24 -0500
Content-Disposition: inline
In-Reply-To: <50B619F1.3000207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Radhesh Fadnis <radhesh.fadnis@ti.com>, Jon Hunter <jon-hunter@ti.com>

On Wed, Nov 28, 2012 at 10:04:33AM -0400, Eduardo Valentin wrote:
> Tony, Russell,
>
> On 20-11-2012 13:57, Tony Lindgren wrote:
>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [121117 01:35]:
>>> On Wed, Nov 14, 2012 at 09:26:43AM +0000, Russell King - ARM Linux wrote:
>>> And the randconfig found:
>>>
>>> drivers/staging/omap-thermal/omap-bandgap.c: In function 'omap_bandgap_readl':
>>> drivers/staging/omap-thermal/omap-bandgap.c:46:2: error: implicit declaration of function 'readl'
>>> drivers/staging/omap-thermal/omap-bandgap.c: In function 'omap_bandgap_writel':
>>> drivers/staging/omap-thermal/omap-bandgap.c:51:2: error: implicit declaration of function 'writel'
>>>
>>> Which, as its in staging, maybe its not important but it's another source
>>> of unnecessary failure.
>
> Well, it is important, thanks for checking this code. I appreciate if  
> you keep your report.
>
>>
>> Radhesh & Eduardo, can you fix this?
>>
>
> This has been already fixed:
> https://patchwork.kernel.org/patch/1734621/
>
> And is already queued by Greg (staging-next):
> http://git.kernel.org/?p=linux/kernel/git/gregkh/staging.git;a=commit;h=2aeeb8acfc19f8a9f283081bbf77919b61b92042

Good.  Now, there's also this too:

drivers/staging/omap-thermal/omap-thermal-common.c: In function 'omap_thermal_expose_sensor':
drivers/staging/omap-thermal/omap-thermal-common.c:259:28: error: storage size of 'pdata' isn't known
drivers/staging/omap-thermal/omap-thermal-common.c:261:2: error: 'data' undeclared (first use in this function)
drivers/staging/omap-thermal/omap-thermal-common.c:264:3: error: implicit declaration of function 'omap_thermal_build_pdata'
drivers/staging/omap-thermal/omap-thermal-common.c: In function 'omap_thermal_build_cpufreq_clip':
drivers/staging/omap-thermal/omap-thermal-common.c:330:41: error: dereferencing pointer to incomplete type
drivers/staging/omap-thermal/omap-thermal-common.c:343:3: error: invalid use of undefined type 'struct freq_clip_table'
drivers/staging/omap-thermal/omap-thermal-common.c:343:3: error: invalid use of undefined type 'struct freq_clip_table'
drivers/staging/omap-thermal/omap-thermal-common.c:343:6: error: dereferencing pointer to incomplete type
drivers/staging/omap-thermal/omap-thermal-common.c:344:3: error: invalid use of undefined type 'struct freq_clip_table'
drivers/staging/omap-thermal/omap-thermal-common.c:344:3: error: invalid use of undefined type 'struct freq_clip_table'
drivers/staging/omap-thermal/omap-thermal-common.c:344:6: error: dereferencing pointer to incomplete type
drivers/staging/omap-thermal/omap-thermal-common.c:345:3: error: invalid use of undefined type 'struct freq_clip_table'
drivers/staging/omap-thermal/omap-thermal-common.c:345:3: error: invalid use of undefined type 'struct freq_clip_table'
drivers/staging/omap-thermal/omap-thermal-common.c:345:6: error: dereferencing pointer to incomplete type
drivers/staging/omap-thermal/omap-thermal-common.c:375:2: error: too many arguments to function 'cpufreq_cooling_register'

Is it also fixed in Gregkh's staging-next branch?
