From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 3/4] Added sleep support to UART
Date: Wed, 20 Aug 2008 15:26:14 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE39430626EBB@vaebe110.NOE.Nokia.com>
References: <87iqu2rac0.fsf@trdhcp146196.ntc.nokia.com> <1218786440-28089-1-git-send-email-jouni.hogander@nokia.com> <20080820114021.GD29374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:41232 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797AbYHTM0r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 08:26:47 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080820114021.GD29374@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, jouni.hogander@nokia.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Tony Lindgren [mailto:tony@atomide.com] 
>Sent: 20 August, 2008 14:40
>To: Hogander Jouni (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org; Kristo Tero (Nokia-D/Tampere)
>Subject: Re: [PATCH 3/4] Added sleep support to UART
>
>* Jouni Hogander <jouni.hogander@nokia.com> [080815 10:48]:
>> From: Tero Kristo <tero.kristo@nokia.com>
>> 
>> UART usage (e.g. serial console) now denies sleep for 5 
>seconds. This 
>> makes it possible to use serial console when dynamic idle is 
>enabled. 
>> Write 1 to /sys/power/clocks_off_while_sleep to enable uart clock 
>> disable on idle. Without this omap won't enter retention.
>> 
>> Also moved code from pm-debug.c to serial.c, and made pm24xx.c use 
>> this new implementation.
>
>This looks OK and safe to apply now. I guess it depends on the 
>GPIO patch above though?

Yes, checks for the sleep conditions and dynamic clock disable / enable
mechanism are introduced in the GPIO patch. I think it would be possible
to change the order of dependency if needed though, but this would
require changes to both patches.

-Tero
