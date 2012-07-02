From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 3/3] ARM: OMAP2+: onenand: prepare for gpmc driver
 migration
Date: Mon, 2 Jul 2012 12:29:03 -0500
Message-ID: <4FF1DA5F.9000409@ti.com>
References: <cover.1340778002.git.afzal@ti.com> <0a4c9edc1328f7789491e2acf5138364e08bf2cb.1340778003.git.afzal@ti.com> <20120627145844.GL3483@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E9A03A6@DBDE01.ent.ti.com> <20120628123207.GG19842@atomide.com> <4FEC89B9.3090404@ti.com> <20120702063651.GO4202@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E9A1BB7@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46995 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab2GBR3J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 13:29:09 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9A1BB7@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 07/02/2012 04:43 AM, Mohammed, Afzal wrote:
> Hi Tony,
> 
> On Mon, Jul 02, 2012 at 12:06:51, Tony Lindgren wrote:
>> * Jon Hunter <jon-hunter@ti.com> [120628 09:48]:
> 
>>> The above change seems to imply that Tony's n900 is dependent on the bootloader settings
>>> and not those being set by the kernel. Ideally, we should not need to set the async mode
>>> in the onenand before we set the onenand timings in the gpmc (per Afzal's changelog
>>> comment). This appears backwards.
>>
>> That should not be the case, I'm more likely to believe in Afzal's explanation.
> 
> Not sure whether you are fine with fixing up this patch with added diff
> 
> Assuming inferences so far is not wrong, right now this patch with the added diff
> would be perfectly fine.
> 
> Problem would happen when we are at a stage to do gpmc reset using hwmod [seems
> miles to go before I sleep {or read gpmc hwmod reset} ;)]. If bootloader left
> onenand configured in sync mode, to switch onenand to async mode, first configuring
> gpmc to sync mode would be required & for that we need frequency information
> from onenand and to get that information from onenand, gpmc has to be configured
> for sync mode and to configure gpmc to sync mode ....

You are concerned about hwmod performing a reset of the gpmc during
boot? We should be able to use the HWMOD_INIT_NO_RESET flag to prevent
this. Would that work?

Cheers
Jon
