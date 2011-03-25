From: Andy Green <andy@warmcat.com>
Subject: Re: [RFC PATCH 1/2] OMAP2+: add cpu id register to MAC address helper
Date: Fri, 25 Mar 2011 12:08:59 +0000
Message-ID: <4D8C85DB.6060001@linaro.org>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com> <20110324212729.14936.98130.stgit@otae.warmcat.com> <201103251249.32578.arnd@arndb.de>
Reply-To: andy.green@linaro.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57918 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab1CYMJH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 08:09:07 -0400
Received: by wwa36 with SMTP id 36so1289280wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 05:09:05 -0700 (PDT)
In-Reply-To: <201103251249.32578.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, patches@linaro.org, nicolas.pitre@linaro.org, x0132446@ti.com, s-jan@ti.com, tony@atomide.com

On 03/25/2011 11:49 AM, Somebody in the thread at some point said:
> On Thursday 24 March 2011, Andy Green wrote:
>> Introduce a generic helper function that can set a MAC address using
>> data from the OMAP unique CPU ID register.
>>
>> For comparison purposes this produces a MAC address of
>>
>>    2e:40:70:f0:12:06
>>
>> for the ethernet device on my Panda.
>>
>>
>> Note that this patch requires the fix patch for CPU ID register
>> indexes previously posted to linux-omap, otherwise the CPU ID is
>> misread on Panda by the existing function to do it.  This patch
>> is already on linux-omap.
>>
>> "OMAP2+:Common CPU DIE ID reading code reads wrong registers for OMAP4430"
>> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=b235e007831dbf57710e59cd4a120e2f374eecb9
>>
>> Signed-off-by: Andy Green<andy.green@linaro.org>
>
> Acked-by: Arnd Bergmann<arnd@arndb.de>

Thanks.

> TI folks: While this is a working solution, I still think it would
> be good to get an officially sanctioned method that allows the creation
> of a IEEE 802 MAC address in a range assigned to TI instead of using
> an address from the locally administered range.
>
> Is that something that can be done?

Having a proper MAC from IEEE assigned for each interface is of course 
ideal.

But even if that happened today though, on Panda there is no "board 
identity storage" to put the reserved MAC addresses in to bind it to the 
physical board.  If you try to manage them on SD Card, you have the 
problem of dealing with correct MAC addresses needing putting there 
again every time it is nuked.  So it doesn't in itself help in the Panda 
case.

David Anders mentioned yesterday that for next OMAP board, he probably 
puts a general board identity EEPROM where one could stash MACs.  This 
kind of API can be extended to query the EEPROM at device-register-time 
and fetch the MAC instead of compute it.  So I think we go in a 
reasonable direction even when it is possible to get assigned MACs.

-Andy
