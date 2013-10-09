From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/3] dma: cppi41: more suspend/resume patches
Date: Wed, 09 Oct 2013 09:23:38 +0200
Message-ID: <5255047A.5010609@gmail.com>
References: <1380634271-27588-1-git-send-email-zonque@gmail.com> <20131009064124.GA3529@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:39552 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab3JIHXw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 03:23:52 -0400
In-Reply-To: <20131009064124.GA3529@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

On 09.10.2013 08:41, Sebastian Andrzej Siewior wrote:
> * Daniel Mack | 2013-10-01 15:31:08 [+0200]:
> 
>> Patch #1 restores more registers on resume time.
>>
>> Patch #2 is a cosmetic cleanup that emerged while digging through the
>> driver and gaining a basic idea of how it's implemented. Nothing fancy.
> 
> I'm fine with those two.
> 
>>
>> Patch #3, however, gives me headaches. I can't fully explain what's
>> going on, but I can tell for sure that if fixes a problem that I stared
>> on for many hours.
> 
> I'm still trying to verify if it breaks something or not. So I haven't
> forgotten about this.

Ok, thank you very much for the update :) I can of course test
alternative patches if you have any.

Could you actually reproduce the issue I described by sending your board
to suspend?


Daniel
