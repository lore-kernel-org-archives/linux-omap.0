From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 1/2] serial: 8250: add UPF_NO_EMPTY_FIFO_READ flag
Date: Tue, 17 Nov 2009 23:09:49 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA689E5F@dbde02.ent.ti.com>
References: <1258412020-31946-1-git-send-email-vikram.pandita@ti.com>
 <20091117170622.GC29266@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57830 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753697AbZKQRju convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 12:39:50 -0500
In-Reply-To: <20091117170622.GC29266@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Tony

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony
>Lindgren
>Sent: Tuesday, November 17, 2009 11:06 AM
>To: Pandita, Vikram
>Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh
>Subject: Re: [PATCH 1/2] serial: 8250: add UPF_NO_EMPTY_FIFO_READ flag
>
>* Vikram Pandita <vikram.pandita@ti.com> [091116 15:00]:
>> OMAP3630 and OMAP4430 UART IP blocks have a restriction wrt RX FIFO.
>> Empty RX fifo read causes an abort. OMAP1/2/3 do not have this restriction.
>>
>> So interoduce a flag in 8250 driver: UPF_NO_EMPTY_FIFO_READ
>>
>> If this flag is specified for an 8250 port, then first check if rx fifo has
>> contents, and only then proceed to read the fifo.
>>
>> The change affects only boards passing this flag in port data and hence is
>> non-disruptive for other boards.
>>
>> First reported/fixed on omap4430 by Shilimkar, Santosh
>
>This should go to linux-serial@vger.kernel.org and Alan Cox.

Patches were posted to l-o for review. Next step was to get it to the right subsystem.

I thought Alan Cox stepped down from the maintainership of serial/tty subsystem.
Not sure if Andrew Morton is taking these patches to MM tree for now.
Any idea?

>
>Regards,
>
>Tony
<snip>

