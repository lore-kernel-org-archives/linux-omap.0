From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] omap: dma: Clear status registers on enable/disable irq.
Date: Sun, 06 May 2012 18:50:16 +0300
Message-ID: <4FA69DB8.7060000@bitmer.com>
References: <1334954578-10478-1-git-send-email-oleg.matcovschi@ti.com> <20120504165146.GB5613@atomide.com> <1633215.yCrxk1mQVq@acer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:59262 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786Ab2EFPvk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 6 May 2012 11:51:40 -0400
In-Reply-To: <1633215.yCrxk1mQVq@acer>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Oleg Matcovschi <oleg.matcovschi@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, Peter Ujfalusi <peter.ujfalusi@ti.com>

On 05/04/2012 10:39 PM, Janusz Krzysztofik wrote:
>> This seems like a nice fix to me. As it affects all omaps, I'd like to
>> see some tested-by from Janusz/Jarkko/Peter. Can you guys give it a 
> try
>> with some audio tests?
> 
> OK, I can do, but perhaps not before next Saturday, when I'm back home, 
> able to actually listen to the audio, not only watch the IRQ counters 
> rising up ;-).
> 
Ok from omap3

Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
