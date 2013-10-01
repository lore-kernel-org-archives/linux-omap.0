From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3 4/5] dma: cppi41: only allocate descriptor memory once
Date: Tue, 01 Oct 2013 15:09:27 +0200
Message-ID: <524AC987.5000301@gmail.com>
References: <1379861404-8250-1-git-send-email-zonque@gmail.com> <1379861404-8250-5-git-send-email-zonque@gmail.com> <20130926082604.GA24205@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:55174 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab3JANJa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Oct 2013 09:09:30 -0400
In-Reply-To: <20130926082604.GA24205@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, sergei.shtylyov@cogentembedded.com, vinod.koul@intel.com, dan.j.williams@intel.com, balbi@ti.com, gregkh@linuxfoundation.org

Hi Sebastian,

sorry for the long delay, I got distracted by other things.


On 26.09.2013 10:26, Sebastian Andrzej Siewior wrote:
> * Daniel Mack | 2013-09-22 16:50:03 [+0200]:
> 
>> cdd->cd and cdd->descs_phys are allocated DESCS_AREAS times from
>> init_descs() and freed as often from purge_descs(). This leads to both
>> memory leaks and double-frees.
>>
>> Fix this by pulling the calls to dma_{alloc,free}_coherent() out of the
>> loops.
>>
>> While at it, remove the intermediate variable mem_decs (I guess it was
>> only there to make the code comply to the 80-chars CodingSytle rule).
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
> 
> Please don't merge the memory descriptors. The idea was initially to
> allocate multiple small descriptors instead one big. The descrriptor
> turned out to be enough so it looks like the way it looks.
> If you want to clean this up, please either remove the for loop and
> allocate only one memory area or please prepare for multiple descripors
> (I think two is the upper limit).

Well, I didn't merge the descriptors. Look again at my changes please.

A simplified version of the code as it stands is:

  for (i = 0; i < DESCS_AREAS; i++)
    cdd->cd = dma_alloc_coherent(dev, ..., &cdd->descs_phys, GFP_KERNEL);

  for (i = 0; i < DESCS_AREAS; i++)
    dma_free_coherent(dev, mem_decs, cdd->cd, cdd->descs_phys);

So you're effectively allocating and freeing the same pointer
DESCS_AREAS times, which is certainly not what you wanted.

And this just doesn't hit you because DESCS_AREAS is always 1:

  BUILD_BUG_ON(DESCS_AREAS != 1);


So, after all, my patch doesn't really change any of the runtime
behaviour. Consider it a cosmetic cleanup if you wish :)


Thanks,
Daniel

