From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
Date: Mon, 3 Jan 2011 16:34:47 +0000
Message-ID: <20110103163447.GB2911@n2100.arm.linux.org.uk>
References: <201005152214.53993.sshtylyov@ru.mvista.com> <4D21F3F2.6090302@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34120 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755520Ab1ACQe5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 11:34:57 -0500
Content-Disposition: inline
In-Reply-To: <4D21F3F2.6090302@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com

On Mon, Jan 03, 2011 at 07:06:10PM +0300, Sergei Shtylyov wrote:
> Hello.
>
> On 15-05-2010 22:14, Sergei Shtylyov wrote:
>
>> Add support for Texas Instuments Communication Port Programming Interface 4.1
>> (CPPI 4.1) used on OMAP-L1x/DA8xx and AM35x.
>
>> At this moment, only the DMA controller and queue manager are supported.
>> Support for the buffer manager is lacking but these chips don't have it anyway.
>
>> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>> Signed-off-by: Sekhar Nori<nsekhar@ti.com>
>
>    Russell, you have recently discarded this patch from your patch 
> system. Can we know the reason?

It was recently discussed with TI, and various people raised concerns
about it.  I don't remember the exact details, and I wish they'd raise
them with the patch author directly.  It may have been that it's
inventing its own API rather than using something like the DMA engine
API.

Adding linux-omap to try to get a response there.
