From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 2/4] PM: Workaround for taking care of gpio clocks
Date: Thu, 21 Aug 2008 14:07:57 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE394306273A5@vaebe110.NOE.Nokia.com>
References: <87iqu2rac0.fsf@trdhcp146196.ntc.nokia.com> <1218786439-28070-1-git-send-email-jouni.hogander@nokia.com> <20080820113715.GC29374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49254 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033AbYHULIl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 07:08:41 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080820113715.GC29374@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, jouni.hogander@nokia.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org 
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext 
>Tony Lindgren
>Sent: 20 August, 2008 14:37
>To: Hogander Jouni (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 2/4] PM: Workaround for taking care of gpio clocks
>
>* Jouni Hogander <jouni.hogander@nokia.com> [080815 10:47]:
>> In omap3 gpios 2-6 are in per domain. Functional clocks for these 
>> should be disabled. This patch is needed until gpio driver disables 
>> gpio clocks.
>> 
>> GPIO modules in PER domain are not able to act as a wake up 
>source if 
>> PER domain is in retention. PER domain sleep transition 
>before MPU is 
>> prevented by leaving icks active. PER domain still enters retention 
>> together with MPU. When this happens IOPAD wake up mechanism is used 
>> for gpios.
>
>As we talked offline.. Should we pass the GPIO wake-up 
>configuration from board-*.c files? Or can we always 
>automatically do this safely on 34xx?

After some investigation it seems that we can configure wake-up events
for almost every GPIO from the padconfigs. There are only 2 pins that do
not seem to have this functionality, however I am not sure if this is a
documentation bug or what because it is strange that only 2 pins lack
this capability. GPIOs 32 and 187 are missing wake-up capability from
padconfig.

Because of this, our proposal would be to make GPIO clock switching
global, but this would be enabled from a sysfs entry pretty much like
how it is in the patches now. However, this would be separated from UART
clock switching. So, we would introduce two new sysfs files:
uart_clocks_off_while_idle and gpio_clocks_off_while_idle. This would
avoid introducing new complexity in to the idle loop.

How does this sound like?

-Tero
