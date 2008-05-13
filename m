From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: TWL4030 keypad timeout interrupt
Date: Tue, 13 May 2008 09:28:21 -0500
Message-ID: <3d1886c4eeb5320b5d443df10b6bed87@felipebalbi.com>
References: <20080513135417.GL4244@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:45691 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756775AbYEMO2X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 10:28:23 -0400
In-Reply-To: <20080513135417.GL4244@gandalf.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>



On Tue, 13 May 2008 16:54:17 +0300, Felipe Balbi <felipe.balbi@nokia.com>
wrote:
> Hi all,
> 
> I noted whenever we release a key in omap-twl4030.c driver it generates
> two interrupts: one for release event and one for a timeout event.
> 
> Is that expected or is that a bug somewhere in the driver ?
> 
> It's easily noted by cat /proc/interrupts ;-)

Replying to myself as I found some more clues.

By checking the code I could see that only rising edge of
timeout interrupt is being enabled. Also timeout register
is at 0xd6, but code is writing 0x04...

So if i read it correctly, we might have 0 set as our timeout.

which might explain why we only see the timeout interrupt
when releasing the key.

Am I right ?

I might be completely wrong here, but that extra interrupt
happening all the time is just bugging me :-p

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

