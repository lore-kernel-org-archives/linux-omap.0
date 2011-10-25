From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: remove NR_IRQS dependency for ARM-specific HARDIRQ_BITS definition
Date: Tue, 25 Oct 2011 15:36:10 +0200
Message-ID: <87wrbtnqgl.fsf@ti.com>
References: <1319541948-10035-1-git-send-email-khilman@ti.com>
	<alpine.LFD.2.02.1110251343580.31312@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:57903 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933399Ab1JYNgX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Oct 2011 09:36:23 -0400
Received: by mail-bw0-f41.google.com with SMTP id zt12so586874bkb.0
        for <linux-omap@vger.kernel.org>; Tue, 25 Oct 2011 06:36:19 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1110251343580.31312@xanadu.home> (Nicolas
	Pitre's message of "Tue, 25 Oct 2011 13:45:27 +0200 (CEST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Nicolas Pitre <nico@fluxnic.net> writes:

> On Tue, 25 Oct 2011, Kevin Hilman wrote:
>
>> As a first step towards removing NR_IRQS, remove the ARM customization
>> of HARDIRQ_BITS based on NR_IRQS.
>> 
>> The generic code in <linux/hardirq.h> already has a default value of
>> 10 for HARDIRQ_BITS which is the max used on ARM, so let's just remove
>> the NR_IRQS based customization and use the generic default.
>> 
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Thanks.

FYI, this is now in Russell's patch system as 7140/1:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7140/1

Kevin
