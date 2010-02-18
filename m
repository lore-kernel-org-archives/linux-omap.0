From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 5/6] Mailbox: sleeping function called from invalid
 context fix
Date: Thu, 18 Feb 2010 00:16:36 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA2B9B1D@dlee06.ent.ti.com>
References: <20100215.154846.212385655.Hiroshi.DOYU@nokia.com>
	<496565EC904933469F292DDA3F1663E602CA2B9285@dlee06.ent.ti.com>
	<20100218010509.GK21755@atomide.com>
 <20100218.071127.133417907.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37842 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181Ab0BRGQm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 01:16:42 -0500
In-Reply-To: <20100218.071127.133417907.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi,

>-----Original Message-----
>From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
>Sent: Wednesday, February 17, 2010 11:11 PM
>To: tony@atomide.com
>Cc: Guzman Lugo, Fernando; linux-omap@vger.kernel.org
>Subject: Re: [PATCH 5/6] Mailbox: sleeping function called from invalid
>context fix
>
>From: ext Tony Lindgren <tony@atomide.com>
>Subject: Re: [PATCH 5/6] Mailbox: sleeping function called from invalid
>context fix
>Date: Thu, 18 Feb 2010 02:05:10 +0100
>
>> * Guzman Lugo, Fernando <x0095840@ti.com> [100215 23:22]:
>>>
>>> Hi,
>>>
>>> >-----Original Message-----
>>> >From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
>>> >Sent: Monday, February 15, 2010 7:49 AM
>>> >To: Guzman Lugo, Fernando
>>> >Cc: linux-omap@vger.kernel.org
>>> >Subject: Re: [PATCH 5/6] Mailbox: sleeping function called from invalid
>>> >context fix
>>> >
>>> >Hi Fernando,
>>> >
>>> >From: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
>>> >Subject: [PATCH 5/6] Mailbox: sleeping function called from invalid
>context
>>> >fix
>>> >Date: Sat, 13 Feb 2010 02:42:16 +0100
>>> >
>>> >> From e06b2716824f225747c4dc83ed2623d0160ae132 Mon Sep 17 00:00:00
>2001
>>> >> From: Fernando Guzman Lugo <x0095840@ti.com>
>>> >> Date: Fri, 29 Jan 2010 17:12:24 -0600
>>> >> Subject: [PATCH] Mailbox: sleeping function called from invalid
>context
>>> >fix
>>> >>
>>> >> This patch fixes this bug:
>>> >> BUG: sleeping function called from invalid context
>>> >> Inside omap2_mbox_startup is called clk_get_sys that can sleep,
>>> >> therefore omap2_mbox_startup can sleep but it is call in an atomic
>>> >> context . So the spinlock is change for a semaphore.
>>> >
>>> >"mboxes_lock" is used to maintain the global list of mailbox
>>> >instances, which belong to a single mailbox H/W module, but they are
>>> >logical channels from S/W perspective. Both "->ops->startup()" and
>>> >"->ops->shutdown()" are being executed against the above single H/W
>>> >module, and a mailbox H/W module is totally __independent__ of the
>>> >registration of logical mailboxes, which are (un)registered with
>>>
>>> Yes, they are independent of each other, and can be executed at the same
>time. I am agreed with your patch; that should be the right solution, so
>you can drop my patch.
>>
>> Hiroshi & Fernando, if you want me to merge this series, please post
>> it one more time with right patches and ack's from Hiroshi. Please
>> Cc also linux-arm-kernel so it gets reviewed there. The merge window
>> is about to open, so we're running out of time..
>
>Ok, I'll take care of them.

Let me send the set of patches again.

Regards,
Fernando.

