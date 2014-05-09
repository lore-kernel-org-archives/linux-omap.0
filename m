From: Roger Quadros <rogerq@ti.com>
Subject: Re: omap4-panda-es boot issues with v3.15-rc4
Date: Fri, 9 May 2014 11:23:32 +0300
Message-ID: <536C9084.50209@ti.com>
References: <536B7E44.2040303@ti.com> <7hppjos2w2.fsf@paris.lan>	<CAGa+x84VB3CXDm71JWxHx1-Qk1xVNeXdwUjZnb42_wg+piOzzA@mail.gmail.com>	<20140508165558.GB2198@atomide.com>	<20140508184055.GC2198@atomide.com> <7hha4zsyro.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46585 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715AbaEIIYN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 04:24:13 -0400
In-Reply-To: <7hha4zsyro.fsf@paris.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: "Menon, Nishanth" <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, Taras Kondratiuk <taras.kondratiuk@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kristo, Tero" <t-kristo@ti.com>, Paul Burton <paul.burton@imgtec.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Kevin,

On 05/09/2014 01:15 AM, Kevin Hilman wrote:
> Tony Lindgren <tony@atomide.com> writes:
> 
> [...]
> 
>> ..but I think I found the cause for recent hangs on panda, just a wild
>> guess based on looking at the recent cpuidle patches after v3.14.
>>
>> Looks like reverting 0b89e9aa2856 (cpuidle: delay enabling interrupts
>> until all coupled CPUs leave idle) makes booting work reliably again
>> on panda.
>>
>> Can you guys confirm, so far no issues here after few boot tests,
>> but it might be too early to tell.
> 
> Reverting that makes things a bit more stable, but it still eventually
> fails in the same way.  For me it took 8 boots for it to eventually
> fail.
> 
> However, if I build with CONFIG_CPU_IDLE=n, it becomes much more stable
> (20+ boots in a row and still going.)
> 

Can you please test with CPU_IDLE enabled but C3 disabled as in below patch?
It worked for me 10/10 boots.

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 01fc710..99362ff 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -206,7 +206,12 @@ static struct cpuidle_driver omap4_idle_driver = {
 			.desc = "CPUx OFF, MPUSS OSWR",
 		},
 	},
-	.state_count = ARRAY_SIZE(omap4_idle_data),
+/*
+ * 	Disable C3 state since it is unstable
+ *
+ *	.state_count = ARRAY_SIZE(omap4_idle_data),
+ */
+	.state_count = 2,
 	.safe_state_index = 0,
 };
 



