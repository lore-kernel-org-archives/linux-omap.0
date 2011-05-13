From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [PATCH 1/2] Initial B&N Nook Color (encore) support.
Date: Thu, 12 May 2011 23:52:08 -0400
Message-ID: <8D96E746-8C8F-44B1-9AFE-8A71F8AF082D@linuxhacker.ru>
References: <1304891407-29364-1-git-send-email-green@linuxhacker.ru> <1304891407-29364-2-git-send-email-green@linuxhacker.ru> <4DC791C9.9040709@compulab.co.il>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from linuxhacker.ru ([217.76.32.60]:50115 "EHLO fiona.linuxhacker.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754949Ab1EMDwg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 May 2011 23:52:36 -0400
In-Reply-To: <4DC791C9.9040709@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello!

On May 9, 2011, at 3:03 AM, Igor Grinberg wrote:

>> Bare-bones board file, comes with serial console, gpio keys,
>> MMC/SDCard and USB support.
>> 
>> Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
>> ---
> 
> In general, here you should write the version history of your patch...

umm, ok.
Do you think the history of the changes is important in this case, though?
I mean it's mostly the case of "kill unneeded includes, fix style, fix incorrect mux package type" and so on.
Nothing of real interest to anybody.

>> +static void __init omap_encore_init(void)
>> +{
>> +	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> 
> You select CBP package in Kconfig, but pass CBB here?

Ah, indeed, thanks for catching this.

>> -nookcolor		MACH_NOOKCOLOR		NOOKCOLOR		3284
>> +encore			MACH_ENCORE		ENCORE			3284
>> hkdkc100		MACH_HKDKC100		HKDKC100		3285
>> ts42xx			MACH_TS42XX		TS42XX			3286
>> aebl			MACH_AEBL		AEBL			3287
> 
> You should contact Russell for this kind of stuff.

Yes, I already did.
I am carrying it as part of the patch so that it's actually buildable while
awaiting for the decision.

> I don't think you should be patching it directly...
> If you want to tell us that your patch should be applied with this
> change to mach-types, then it would be better to make a separate
> patch for it and describe it in your cover letter.

Hm, ok.

Thanks for the feedback.

Bye,
    Oleg