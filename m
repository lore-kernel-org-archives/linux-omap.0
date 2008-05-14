From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: TWL4030 keypad timeout interrupt
Date: Wed, 14 May 2008 11:16:29 +0300
Message-ID: <20080514081629.GA17908@gandalf.research.nokia.com>
References: <20080513135417.GL4244@gandalf.research.nokia.com> <3d1886c4eeb5320b5d443df10b6bed87@felipebalbi.com> <023e01c8b580$8242db00$7f8818ac@ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34665 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbYENI2U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2008 04:28:20 -0400
Content-Disposition: inline
In-Reply-To: <023e01c8b580$8242db00$7f8818ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Girish <girishsg@ti.com>
Cc: 'Felipe Balbi' <me@felipebalbi.com>, felipe.balbi@nokia.com, 'Linux OMAP Mailing List' <linux-omap@vger.kernel.org>

On Wed, May 14, 2008 at 10:38:09AM +0530, ext Girish wrote:
> 
>  
> >
> >
> >On Tue, 13 May 2008 16:54:17 +0300, Felipe Balbi 
> ><felipe.balbi@nokia.com>
> >wrote:
> >> Hi all,
> >> 
> >> I noted whenever we release a key in omap-twl4030.c driver it 
> >> generates two interrupts: one for release event and one for 
> >a timeout event.
> >> 
> >> Is that expected or is that a bug somewhere in the driver ?
> >> 
> >> It's easily noted by cat /proc/interrupts ;-)
> >
> >Replying to myself as I found some more clues.
> >
> >By checking the code I could see that only rising edge of 
> >timeout interrupt is being enabled. Also timeout register is 
> >at 0xd6, but code is writing 0x04...
> >
> 
> No, the code is writing to 0x00D2 + 0x04 (the t2keypad base address: 0x00D2). 

Ok, good :-)
thanks

> 
> >So if i read it correctly, we might have 0 set as our timeout.
> >
> >which might explain why we only see the timeout interrupt when 
> >releasing the key.
> >
> >Am I right ?
> 
> Well, the timeout is here to help the controller come out of hangs, if any. 

But is it possible that whenever we release a key we get a timeout? I
think something is wrong there.

-- 
	- Balbi
