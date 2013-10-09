From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/3] dma: cppi41: more suspend/resume patches
Date: Wed, 09 Oct 2013 09:31:51 +0200
Message-ID: <52550667.9010203@gmail.com>
References: <1380634271-27588-1-git-send-email-zonque@gmail.com> <20131009064124.GA3529@linutronix.de> <5255047A.5010609@gmail.com> <52550583.5050506@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:41324 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab3JIHby (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 03:31:54 -0400
In-Reply-To: <52550583.5050506@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com

On 09.10.2013 09:28, Sebastian Andrzej Siewior wrote:
> On 10/09/2013 09:23 AM, Daniel Mack wrote:
>> Ok, thank you very much for the update :) I can of course test
>> alternative patches if you have any.
>>
>> Could you actually reproduce the issue I described by sending your board
>> to suspend?
> 
> No, I don't have "mem", just "freeze".

Sounds like you need to update your cm3 firmware. I built mine from this
tree:

      git://arago-project.org/git/projects/am33x-cm3.git
      Branch "next3"
      AM335xPSP_04.06.00.08-141-g1628306

I can also send you my binary in PM if you want me to.

> I try to test if this is a
> regression compared to my earlier testing. If not then it looks good I
> would say.

Ok.


Thanks,
Daniel

