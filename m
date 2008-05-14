From: "Girish" <girishsg@ti.com>
Subject: RE: TWL4030 keypad timeout interrupt
Date: Wed, 14 May 2008 10:38:09 +0530
Message-ID: <023e01c8b580$8242db00$7f8818ac@ent.ti.com>
References: <20080513135417.GL4244@gandalf.research.nokia.com> <3d1886c4eeb5320b5d443df10b6bed87@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:58461 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932163AbYENFId (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 May 2008 01:08:33 -0400
In-Reply-To: <3d1886c4eeb5320b5d443df10b6bed87@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Felipe Balbi' <me@felipebalbi.com>, felipe.balbi@nokia.com
Cc: 'Linux OMAP Mailing List' <linux-omap@vger.kernel.org>

 
>
>
>On Tue, 13 May 2008 16:54:17 +0300, Felipe Balbi 
><felipe.balbi@nokia.com>
>wrote:
>> Hi all,
>> 
>> I noted whenever we release a key in omap-twl4030.c driver it 
>> generates two interrupts: one for release event and one for 
>a timeout event.
>> 
>> Is that expected or is that a bug somewhere in the driver ?
>> 
>> It's easily noted by cat /proc/interrupts ;-)
>
>Replying to myself as I found some more clues.
>
>By checking the code I could see that only rising edge of 
>timeout interrupt is being enabled. Also timeout register is 
>at 0xd6, but code is writing 0x04...
>

No, the code is writing to 0x00D2 + 0x04 (the t2keypad base address: 0x00D2). 

>So if i read it correctly, we might have 0 set as our timeout.
>
>which might explain why we only see the timeout interrupt when 
>releasing the key.
>
>Am I right ?

Well, the timeout is here to help the controller come out of hangs, if any. 

>
>I might be completely wrong here, but that extra interrupt 
>happening all the time is just bugging me :-p




Regards,
Girish


