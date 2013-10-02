From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2 1/5] usb: musb: move port reset to worker
Date: Wed, 02 Oct 2013 13:19:07 +0200
Message-ID: <524C012B.7090902@gmail.com>
References: <1380634797-29541-1-git-send-email-zonque@gmail.com> <1380634797-29541-2-git-send-email-zonque@gmail.com> <20131002104612.GC16680@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:51600 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab3JBLTL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Oct 2013 07:19:11 -0400
In-Reply-To: <20131002104612.GC16680@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

On 02.10.2013 12:46, Sebastian Andrzej Siewior wrote:
> * Daniel Mack | 2013-10-01 15:39:53 [+0200]:
> 
>> musb_port_reset() sleeps, so we can't call it from atomic context. It
>> is, however, called from places inside musb_hub_control() while
>> &musb->lock is held, which leads to a "scheduling while atomic" warning.
> 
> I guess you are hit by the msleep(1) here.

Yes.

>> Fix this by moving the logic into a worker, and call it where the
>> function was previously called directly.
> 
> I *think* the better approach here would be to replace the msleep(1) by
> a busy loop. The thing is that you do now want to continue the operation
> and having the reset in progress. It should complete _right_ _now_ i.e.
> SET_PORT_FEATURE RESET is completed before the the next SET/GET request
> arrives and with a workqueue you can not guarantee this.

Hmm, ok. I'm just not sure what time periods we're really sleeping for
here. After all, we're blocking all interrupts from occuring while the
lock is held.

So my question is rather whether it's sensible at all to hold the lock
while waiting. We might change some of the execution pathes to mutexes
and waitqueues as well. Felipe?



Thanks,
Daniel
