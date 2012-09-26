From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH V2 7/7] ARM: OMAP: Add DT support for timer driver
Date: Wed, 26 Sep 2012 11:11:40 -0500
Message-ID: <5063293C.1080404@gmail.com>
References: <1347579091-3794-1-git-send-email-jon-hunter@ti.com> <1347579091-3794-8-git-send-email-jon-hunter@ti.com> <50632497.2070103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44505 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297Ab2IZQLn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Sep 2012 12:11:43 -0400
Received: by obbuo13 with SMTP id uo13so736128obb.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Sep 2012 09:11:43 -0700 (PDT)
In-Reply-To: <50632497.2070103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 09/26/2012 10:51 AM, Jon Hunter wrote:
> Hi Rob,



>>  #define OMAP3_32K_SOURCE	"omap_32k_fck"
>>  #define OMAP4_32K_SOURCE	"sys_32k_ck"
>>  
>> +#define TIMER_PROP_ALWON	"ti,timer-alwon"
>> +
> 
> I see you made the following comment [1] here ...
> 
> "It would be easier to follow the code if you use the strings directly
> (and you do in some places)."
> 
> I could avoid the above definition.
> 
>>  #ifdef CONFIG_OMAP_32K_TIMER
>>  #define OMAP2_CLKEV_SOURCE	OMAP2_32K_SOURCE
>>  #define OMAP3_CLKEV_SOURCE	OMAP3_32K_SOURCE
>>  #define OMAP4_CLKEV_SOURCE	OMAP4_32K_SOURCE
>>  #define OMAP3_SECURE_TIMER	12
>> +#define TIMER_PROP_SECURE	"ti,timer-secure"
>>  #else
>>  #define OMAP2_CLKEV_SOURCE	OMAP2_MPU_SOURCE
>>  #define OMAP3_CLKEV_SOURCE	OMAP3_MPU_SOURCE
>>  #define OMAP4_CLKEV_SOURCE	OMAP4_MPU_SOURCE
>>  #define OMAP3_SECURE_TIMER	1
>> +#define TIMER_PROP_SECURE	TIMER_PROP_ALWON
>>  #endif
> 
> Are you ok, with having the TIMER_PROP_SECURE definition or would you
> prefer I handle this differently? This is dependent on the kernel config.\

Yes, that's fine.

Rob

> 
> Cheers
> Jon
> 
> [1] http://thread.gmane.org/gmane.linux.ports.arm.omap/84458/focus=84982
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

