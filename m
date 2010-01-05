From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/4] OMAP2: clock: clk2xxx.c doesn't compile if CPUFREQ
 is enabled
Date: Tue, 5 Jan 2010 12:51:50 +0200
Message-ID: <20100105105150.GC11291@nokia.com>
References: <20100105024113.16275.96273.stgit@localhost.localdomain>
 <20100105024204.16275.82098.stgit@localhost.localdomain>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:21757 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab0AEKyr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 05:54:47 -0500
Content-Disposition: inline
In-Reply-To: <20100105024204.16275.82098.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

Hi,

On Tue, Jan 05, 2010 at 03:42:05AM +0100, ext Paul Walmsley wrote:
>From: Felipe Balbi <felipe.balbi@nokia.com>
>
>if we enable CPUFREQ we can't build omap2 for two reasons,
>one of them is fixed by the patch below.
>
>It's failing because the __must_be_array() check in
>ARRAY_SIZE() is failing and printing the following message:
>
>arch/arm/mach-omap2/clock2xxx.c:453: error: negative width in bit-field '<anonymous>'
>
>Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>[paul@pwsan.com: commit message updated; changed rate variable name]

and you forgot to change the variable definition...

>Signed-off-by: Paul Walmsley <paul@pwsan.com>
>---
> arch/arm/mach-omap2/clock2xxx.c |    5 ++++-
> 1 files changed, 4 insertions(+), 1 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
>index d0e3fb7..2f3c3ba 100644
>--- a/arch/arm/mach-omap2/clock2xxx.c
>+++ b/arch/arm/mach-omap2/clock2xxx.c
>@@ -455,12 +455,15 @@ static struct cpufreq_frequency_table freq_table[ARRAY_SIZE(rate_table)];
> void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
> {
> 	struct prcm_config *prcm;
>+	long rate;
> 	int i = 0;
>
>+	sys_ck_rate = clk_get_rate(sclk);

The variable defined is called rate but you use sys_ck_rate. 
I used rate, because that's what other functions are using and 
I wanted to keep the code consistent. Anyways, as is now this patch 
won't compile again :-p

-- 
balbi
