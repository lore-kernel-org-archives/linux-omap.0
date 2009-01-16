From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Reading OMAP3 CONTROL_RAND_KEY_0 register hangs
Date: Fri, 16 Jan 2009 17:11:22 +0100
Message-ID: <4970B1AA.7090403@googlemail.com>
References: <496F6310.30104@googlemail.com> <13B9B4C6EF24D648824FF11BE8967162036D63FEB7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:61578 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755573AbZAPQLa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 11:11:30 -0500
Received: by fg-out-1718.google.com with SMTP id 19so846457fgg.17
        for <linux-omap@vger.kernel.org>; Fri, 16 Jan 2009 08:11:28 -0800 (PST)
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036D63FEB7@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Woodruff, Richard wrote:
>> With OMAP3530 on BeagleBoard we like to read OMAP3's
>> CONTROL_RAND_KEY_0 (0x4800 2318) register with something like
>>
>> printf ("attempting cpu_uid read\n");
>> u32 cpu_uid = *((u32 *) 0x48002318);
>> /* u32 cpu_uid = readl(&ctrl_base->randkey_0); */
>> printf ("cpu_uid read done\n");
> 
> This address is not accessible out side of secure mode along with some other qualifiers.
> 
> Trying to access is futile and will result in an abort.  The control register range is full of readable and aborting addresses.

Is there any hint in TRM (spruf98b.pdf) identifying/marking which 
registers are readable in normal and which are only accessible in 
secure mode?

Thanks

Dirk
