From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Fri, 12 Sep 2014 09:23:24 +0200
Message-ID: <54129F6C.7040508@linutronix.de>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de> <1410377411-26656-10-git-send-email-bigeasy@linutronix.de> <20140911111721.GB17476@xps8300> <54118AAB.2010205@linutronix.de> <5411967A.6090406@hurleysoftware.com> <54119AAA.9080907@linutronix.de> <20140911151114.GD28458@ci00147.xsens-tech.local> <5411C810.7070906@linutronix.de> <2cf997d9-e7de-465b-915d-3a0a5e7b95f7@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45669 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbaILHXa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2014 03:23:30 -0400
In-Reply-To: <2cf997d9-e7de-465b-915d-3a0a5e7b95f7@email.android.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>, Frans Klaver <frans.klaver@xsens.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>

On 09/11/2014 07:04 PM, Frans Klaver wrote:
> On 11 September 2014 18:04:32 CEST, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>> On 09/11/2014 05:11 PM, Frans Klaver wrote:
>>
>>> I can still reproduce it on am335x. I can get out of it as soon as
>>> something else gets written to the console though.
>>>
>>> # echo "<3>something" >/dev/kmsg
>>
>> Is this to stall it or to get out of it?
> 
> This is to get out of it. I do this from an ssh connection after the console got stuck. The 3 kind of ensures the message is actually sent to ttyS0.

Interesting. This shouldn't do anything. If there is a TX operation in
progress then ->start_tx() will simply return and the xmit buffer will
be send once the current TX operation completes.

Is there anything I can do to reproduce this behavior?
This problem only pops-up if you use DMA. With disabled DMA you don't
see this, right?

Sebastian

