From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [QUESTION] How to set static/dynamic dependency between clock
 domains
Date: Fri, 23 Dec 2011 10:01:23 +0100
Message-ID: <4EF44363.4050008@ti.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com> <CACVXFVPOaw7OG7owJw0h7DAe3pRH6nROsy13UeAWPWgLedKY1g@mail.gmail.com> <CAMQu2gwDth6OVTk3PkRCo05QF6WeQvMTJ-d5s33cT35GSVwT=w@mail.gmail.com> <CACVXFVNtaaxB-MRXKBgAZFEkf72nsgcOSHOFsYjspoL0Fv6VWA@mail.gmail.com> <CAMQu2gzs6op9C8jDJ5xEGs7A7ok_GXeD5OxnHiDoeHaKghCJ5g@mail.gmail.com> <CACVXFVOOQVe8u5TFZDYrNqvga-=RJ1mueaaqkBNB-s4BwkhiOw@mail.gmail.com> <CAMQu2gwKgpH_dOBQovgxBR_yTGAiXu=2yPhwgoERv+YD+pO_Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33998 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174Ab1LWJBb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Dec 2011 04:01:31 -0500
In-Reply-To: <CAMQu2gwKgpH_dOBQovgxBR_yTGAiXu=2yPhwgoERv+YD+pO_Sg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Ming Lei <tom.leiming@gmail.com>, Miguel Vadillo <vadillo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Rajendra Nayak <rnayak@ti.com>

Hi Santosh,

On 12/23/2011 9:45 AM, Shilimkar, Santosh wrote:
> On Fri, Dec 23, 2011 at 2:00 PM, Ming Lei<tom.leiming@gmail.com>  wrote:

[...]

>> The only change on iss(CAM) clock domain setting in your commit[1] is to
>> configure CLKTRCTRL as HW_AUTO, instead of previous  SW_WKUP.
>> Once I change flags of iss to CLKDM_CAN_SWSUP [2], the issue can be
>> fixed, so I am wondering if something is wrong about HW_AUTO mode
>> of CAM clock domain.
>>
> Now I recollect the issue and also track a patch in the internal product tree.
> Same is attached and also in the end of the email.
>
> I am lopping Miguel who wrote the patch and Benoit who acked it.
> This should sort out your issue as you have already verified it works.

Ooops, that remains me that I forgot to push it upstream:-(

Since this is a bug fix, if this is too late for 3.3, we can try to push 
it during rc phases.

Paul,

Is that fine for you?

Regards,
Benoit

> From 972d7bb544d3197d7fc1a6c6eb0e2c9cc08d5e9d Mon Sep 17 00:00:00 2001
> From: Miguel Vadillo<vadillo@ti.com>
> Date: Tue, 21 Jun 2011 09:59:45 -0500
> Subject: [PATCH 1/2] OMAP: clockdomain: set iss clk domain to just SWSUP
>
> Since CAM domain(ISS) has no module wake-up dependency
> with any other clock domain of the device and the dynamic
> dependency from L3_main_2 is always disabled, the domain
> needs to be in force wakeup in order to be able to access
> it for configure(sysconfig) it or use it.
>
> Also since there is no clock in the domain managed automatically
> by the hardware, there is no use to configure automatic
> clock domain transition. SW should keep the SW_WKUP domain
> transition as long as a module in the domain is required to
> be functional.
>
> Signed-off-by: Miguel Vadillo<vadillo@ti.com>
> Acked-by: Benoit Cousson<b-cousson@ti.com>
> ---
>   arch/arm/mach-omap2/clockdomains44xx_data.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c
> b/arch/arm/mach-omap2/clockdomains44xx_data.c
> index 6ac8fe2..8d1a061 100644
> --- a/arch/arm/mach-omap2/clockdomains44xx_data.c
> +++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
> @@ -605,7 +605,7 @@ static struct clockdomain iss_44xx_clkdm = {
>   	.clkdm_offs	  = OMAP4430_CM2_CAM_CAM_CDOFFS,
>   	.wkdep_srcs	  = iss_wkup_sleep_deps,
>   	.sleepdep_srcs	  = iss_wkup_sleep_deps,
> -	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
> +	.flags		  = CLKDM_CAN_SWSUP,
>   	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
>   };
>

