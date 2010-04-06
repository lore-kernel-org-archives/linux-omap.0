From: Roger Quadros <roger.quadros@nokia.com>
Subject: Re: [PATCH 0/5] OMAP: RX51: Add LCD Panel Support for N900
Date: Tue, 06 Apr 2010 12:50:42 +0300
Message-ID: <4BBB03F2.5050706@nokia.com>
References: <1269338191-10734-1-git-send-email-roger.quadros@nokia.com> <87pr2datft.fsf@small.ssi.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29247 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556Ab0DFJvv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 05:51:51 -0400
In-Reply-To: <87pr2datft.fsf@small.ssi.corp>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Arnaud Ebalard <arno@natisbad.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi,

ext Arnaud Ebalard wrote:
> Hi Roger,
> 
> Roger Quadros <roger.quadros@nokia.com> writes:
> 
>> These patches get the N900 LCD panel working.
>> Apply's cleanly on 2.6.34-rc2
>>
>> Pre-requisites:
>> https://patchwork.kernel.org/patch/86318/
>> https://patchwork.kernel.org/patch/86319/
>> https://patchwork.kernel.org/patch/86320/
> 
> First, thanks for pushing the missing bits for N900 hardware support
> upstream! I wanted to give your patches a try and test a l-o kernel on
> my N900 (I know I won't have full hardware support ... at the moment).
> 
> Using current l-o tree with your 5 panel patches and the 3 you link on
> patchwork, I initially ended up with a kernel panic in
> omap3_onenand_write_bufferram() (i.e. unrelated to your patches).
> 
> With http://patchwork.ozlabs.org/patch/48337/ (mtd: OneNAND: OMAP3:
> unmap correct DMA buffer), I am able to get the official Nokia
> /sbin/preinit called: then, getbootstate reports a malfunction but
> AFAICT, the panel is working ok.
> 
The getbootstate malfunction is expected as there is no support for it yet in 
mainline. But you should get to shell without that.

You could hack the startup script to spawn a getty on ttyS2. This should get you 
to shell.

so in /sbin/preinit, in start_shell()

-/sbin/getty 115200 ttyS0 -n -l /bin/sh
+/sbin/getty 115200 ttyS2 -n -l /bin/sh

cheers,
-roger
