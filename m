From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Thu, 9 Apr 2015 00:06:58 +0100
Message-ID: <20150408230658.GO4027@n2100.arm.linux.org.uk>
References: <5520E2EE.4080302@gmail.com>
 <CAALWOA_-RkkgvrxZ32U6WFAZ4Wo5hkkaeo9VNBq48JwMVvkMvw@mail.gmail.com>
 <5521A438.1070008@gmail.com>
 <CAALWOA_0r1syy4nPBOvf1evhd5_oX=LWjdZAsQGAoGk8OoXTwg@mail.gmail.com>
 <20150406151939.GG18048@atomide.com>
 <20150406154037.GI18048@atomide.com>
 <5522BEEF.2000405@gmail.com>
 <20150406174245.GJ18048@atomide.com>
 <20150407135713.GL4027@n2100.arm.linux.org.uk>
 <20150407152207.GM18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:44694 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830AbbDHXHM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Apr 2015 19:07:12 -0400
Content-Disposition: inline
In-Reply-To: <20150407152207.GM18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Matthijs van Duin <matthijsvanduin@gmail.com>

On Tue, Apr 07, 2015 at 08:22:08AM -0700, Tony Lindgren wrote:
> Works for me. The above needs the following fix folded in to build:
> 
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -532,7 +532,7 @@ __v7_ca9mp_proc_info:
>  __v7_ca8_proc_info:
>  	.long	0x410fc080
>  	.long	0xff0ffff0
> -	__v7_proc __v7_ca8mp_proc_info, proc_fns = ca8_processor_functions
> +	__v7_proc __v7_ca8_proc_info, __v7_setup, proc_fns = ca8_processor_functions
>  	.size	__v7_ca8_proc_info, . - __v7_ca8_proc_info
>  
>  #endif	/* CONFIG_ARM_LPAE */

Thanks, merged into the original patch.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
