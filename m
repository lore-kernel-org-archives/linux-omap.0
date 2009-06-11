From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: OMAP3xxx hsmmc : MMC3 doesn't work, always times out?
Date: Thu, 11 Jun 2009 23:09:47 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03059BB9AD@dbde02.ent.ti.com>
References: <8CD1B7D1-9B84-45C1-BC91-B44839743500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41528 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417AbZFKRjy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 13:39:54 -0400
In-Reply-To: <8CD1B7D1-9B84-45C1-BC91-B44839743500@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hugo Vincent <hugo.vincent@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "General mailing list for gumstix users." <gumstix-users@lists.sourceforge.net>

<snip>
> 
> You are quite possibly correct, but the level translator I'm using is  
> "invisible" - it doesn't require the transceiver control signals  
> offered only on MMC2. So as far as I know, there is no hardware reason  
> the OMAP MMC3 controller couldn't talk correctly at the electrical  
> level with the card. This is evidenced by the CMD signal being  
> correctly level translated (and this is via the same type of level  
> translator as the data signals are according to the TXS02612  
> datasheet), and toggling correctly(-looking) at the card socket (i.e.  
> between 0 and 3.3V and it's edges synced to the clock signal). The  
> DAT0-DAT3 signals never do anything though.

The MMC3 DAT0-DAT3 lines are muxed with MMC2 DAT4-DAT7. Any chance the
padconfs are being overwritten even though you programmed them
correctly in the bootloader?

- Anand
