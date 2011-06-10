From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 1/8] OMAP2+: clockdomain: Add an api to read idle mode
Date: Fri, 10 Jun 2011 16:38:47 +0530
Message-ID: <4DF1FB3F.1040906@ti.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com> <1307616853-28395-2-git-send-email-rnayak@ti.com> <20110610000715.GA9059@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:38548 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754621Ab1FJLI4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jun 2011 07:08:56 -0400
Received: by mail-vx0-f179.google.com with SMTP id 40so2295604vxi.38
        for <linux-omap@vger.kernel.org>; Fri, 10 Jun 2011 04:08:54 -0700 (PDT)
In-Reply-To: <20110610000715.GA9059@google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org

On 6/10/2011 5:37 AM, Todd Poynor wrote:
> On Thu, Jun 09, 2011 at 04:24:06PM +0530, Rajendra Nayak wrote:
>> Add a clockdomain api to check if hardware supervised
>> idle transitions are enabled on a clockdomain.
>>
> ...
>> + * clkdm_is_idle - Check if the clkdm hwsup/autoidle is enabled
>
> A minor suggestion on naming: "clkdm_allows_idle" seems more accurate
> and a natural complement to the existing clkdm_allow_idle().

Yeah, I agree. I'll change it in my next spin.

Thanks,
Rajendra
>
>
> Todd

