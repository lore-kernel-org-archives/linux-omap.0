From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH 3/3] OMAP3: PM: invoke omap_sram_idle() only when
	sleep_while_idle is enabled
Date: Wed, 18 Mar 2009 09:28:50 +0900
Message-ID: <4d34a0a70903171728w4bdee3bal4582f73a5b6d1c8f@mail.gmail.com>
References: <4d34a0a70903170028t1722d565i35ec12b476427ae6@mail.gmail.com>
	 <878wn4gq0g.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:61914 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbZCRA2x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 20:28:53 -0400
Received: by yw-out-2324.google.com with SMTP id 3so259529ywj.1
        for <linux-omap@vger.kernel.org>; Tue, 17 Mar 2009 17:28:51 -0700 (PDT)
In-Reply-To: <878wn4gq0g.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: OMAP <linux-omap@vger.kernel.org>, q1.kim@samsung.com, Jouni Hogander <jouni.hogander@nokia.com>, kyungmin.park@samsung.com, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

On Tue, Mar 17, 2009 at 11:53 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Kim Kyuwon <chammoru@gmail.com> writes:
>
>> If MPU goes to WFI in the idle thread, execution time becomes a bit
>> slow and the JTAG Debugger doesn't work. This patch is needed for
>> urgent works(e.g. booting and launching application) and debugging.
>
> Kim,
>
> Do you still need this patch when using the new lower-latency C1-state
> patch from Peter which I recently applied to the PM branch?
>
> With that patch, MPU and CORE stay ON, and the clkdomain is not allowed
> to idle so that the latency for C1 is on the order of a few usecs.
>

No, I don't need this patch.
I confirmed that JTAG debugger works with peter's patch, even though
MPU goes to WFI.

Thanks Keven, Peter!

Kyuwon
