From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 05/16] ARM: omap: fix vc.c PMIC error message
Date: Wed, 08 Feb 2012 15:06:15 -0800
Message-ID: <87ty312ae0.fsf@ti.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
	<E1RvAWP-0006H3-1A@rmk-PC.arm.linux.org.uk>
	<20120208184539.GE29796@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:42639 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755092Ab2BHXGS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 18:06:18 -0500
Received: by mail-pw0-f42.google.com with SMTP id wz12so1646460pbc.1
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 15:06:17 -0800 (PST)
In-Reply-To: <20120208184539.GE29796@atomide.com> (Tony Lindgren's message of
	"Wed, 8 Feb 2012 10:45:39 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:06]:
>> While testing on my OMAP3430 platform, this error message was emitted:
>> 
>> omap_vc_init_channel: PMIC info requried to configure vc forvdd_core not populated.Hence cannot initialize vc
>> 
>> Trying to find this message was difficult because it was wrapped across
>> several lines.  It also mis-spells "required", doesn't read very well,
>> and has spaces lacking.  Let's replace it with a more concise:
>> 
>> omap_vc_init_channel: No PMIC info for vdd_core
>> 
>> While we're here, fix a simple spelling error in a comment.
>> 
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> Acked-by: Tony Lindgren <tony@atomide.com>

NAK.

Tony, please use the patches already in your cleanup branch (that came
from my for_3.3/cleanup/pm) that fix this and also fix a similar problem
for VP.

Thanks,

Kevin
