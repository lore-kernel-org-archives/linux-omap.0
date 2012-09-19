From: Paul Walmsley <paul@pwsan.com>
Subject: Re: USB problem on beagleboard clone
Date: Wed, 19 Sep 2012 01:23:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209190122520.13435@utopia.booyaka.com>
References: <5448984682E7954C9BFF27F747A9C6CA56E2C8@dolphin.TIGRIS.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55379 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab2ISBXe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 21:23:34 -0400
In-Reply-To: <5448984682E7954C9BFF27F747A9C6CA56E2C8@dolphin.TIGRIS.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maximilian Schwerin <Maximilian.Schwerin@tigris.de>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Hi

On Fri, 14 Sep 2012, Maximilian Schwerin wrote:

> we've designed two beagle board clones (two different layouts) for a 
> customer. After quite some time without any problems they are now seeing 
> USB problems on some of the boards. I have so far not been able to 
> reproduce the problem...
> 
> The USB port of the OMAP the problems appear on is connected through a 
> TPS65950 to a LAN9514 USB Hub + Ethernet Chip. Attached is the kernel 
> output. I'm not even sure if this is related to our board, or if this 
> might be a misbehaving device?!
> 
> If someone has an idea what this could be and what I could do to fix or 
> at least further debug the problem please speak up.

Are these BeagleBoard 3530 or BeagleBoard XM 3730 clones?

- Paul
