From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP3/4: consolidate cpuidle Makefile
Date: Tue, 08 May 2012 13:45:23 -0700
Message-ID: <87sjfammfw.fsf@ti.com>
References: <1336151921-9485-1-git-send-email-daniel.lezcano@linaro.org>
	<1336151921-9485-3-git-send-email-daniel.lezcano@linaro.org>
	<4FA98153.4050405@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:55035 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753681Ab2EHUpH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 16:45:07 -0400
Received: by dakp5 with SMTP id p5so21568573dak.28
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 13:45:06 -0700 (PDT)
In-Reply-To: <4FA98153.4050405@linaro.org> (Daniel Lezcano's message of "Tue,
	08 May 2012 22:25:55 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 05/04/2012 07:18 PM, Daniel Lezcano wrote:
>> Define a CPU_IDLE section in the makefile, declare the functions in
>> the header files conforming to the kernel coding rules and remove the
>> 'define's in the C files.
>>
>> CONFIG_PM is enabled when CPU_IDLE is enabled because the cpuidle drivers
>> use some functions from the pm subsystem.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> Reviewed-by: Jean Pihet<j-pihet@ti.com>
>> ---
>
> Hi Kevin,
>
> you did not apply this patch. Is it something wrong with it ?
>

oops, the reply was still in my drafts folder... just sent.

Kevin
