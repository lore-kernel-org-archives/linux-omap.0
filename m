From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC 11/24] ARM: omap: clk: list all clk_hw_omap clks to enable/disable
 autoidle
Date: Mon, 04 Jun 2012 14:23:49 +0530
Message-ID: <4FCC779D.7010208@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com> <1338552485-31325-12-git-send-email-rnayak@ti.com> <20120604054417.GU12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:51439 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756569Ab2FDIx4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jun 2012 04:53:56 -0400
Received: by obhx4 with SMTP id x4so7693649obh.20
        for <linux-omap@vger.kernel.org>; Mon, 04 Jun 2012 01:53:54 -0700 (PDT)
In-Reply-To: <20120604054417.GU12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: mturquette@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

On Monday 04 June 2012 11:14 AM, Tony Lindgren wrote:
> * Rajendra Nayak<rnayak@ti.com>  [120601 05:12]:
>> @@ -359,6 +391,8 @@ const struct clk_hw_omap_ops clkhwops_wait = {
>>   	.find_idlest	= omap2_clk_dflt_find_idlest,
>>   	.find_companion	= omap2_clk_dflt_find_companion,
>>   };
>> +late_initcall(omap2_clk_enable_autoidle_all);
>
> With -rc1, the SoC specific late_initcalls need to be called from
> *_init_late that are in mach-omap2/io.c for omap2+.

Thanks for the heads-up. Will take care of it while I move over to
3.5-rc1.

thanks,
Rajendra

>
> Regards,
>
> Tony

