From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: MMC: Add mux for pins
Date: Thu, 18 Jun 2009 08:04:22 +0300
Message-ID: <20090618050418.GC8079@atomide.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702F53D14A4@dbde02.ent.ti.com> <20090617081206.GD6605@atomide.com> <FCCFB4CDC6E5564B9182F639FC35608702F53D18B1@dbde02.ent.ti.com> <87my86yau1.fsf@deeprootsystems.com> <FCCFB4CDC6E5564B9182F639FC35608702F53D18C6@dbde02.ent.ti.com> <878wjqy1yj.fsf@deeprootsystems.com> <4A3972C8.2090502@ti.com> <87zlc6v56x.fsf@deeprootsystems.com> <FCCFB4CDC6E5564B9182F639FC35608702F53D18E7@dbde02.ent.ti.com> <4A39856B.1040203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49232 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbZFRHE2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Jun 2009 03:04:28 -0400
Content-Disposition: inline
In-Reply-To: <4A39856B.1040203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Hugo Vincent <hugo.vincent@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

* Jon Hunter <jon-hunter@ti.com> [090618 03:08]:
>
> Pandita, Vikram wrote:
>>>> The ball/pad numbers may change due to the package, but the registers
>>>> used to configure the pin muxing and the pin muxing options will not
>>>> change. So from a software standpoint it is the same.
>>>>
>>>> The OMAP3530 is available in 3 packages, namely CBB, CBC and CUS
>>>> according to the data manual [1]. The OMAP3430 is only available in
>>>> the CBB package.
>>>>
>>>> What this means is that the name "N28_3430_MMC1_CLK", which associates
>>>> ball N28 with signal MMC1_CLK, is appliable to the OMAP3430 and
>>>> OMAP3530 CBB package, but not applicable to the OMAP3530 CBC and CUS
>>>> packages
>>>> as this ball number does not exist on these packages. This is simply a
>>>> difference in naming of the balls between the packages but does not
>>>> impact the pin muxing options.
>>
>> So looks like I should keep the MMC mux under cpu_is_omap3430()
>> And not include 3530 as CBC and CUS may not be valid cases for this mux.
>
> Actually, the mux configuration is still valid for the CBC and CUS  
> packages. The only difference is the balls have different names. Sorry  
> if this is not clear.
>
> For example, on the OMAP3530 CBB package if you look at ball N28 you  
> will find:
>
> mux-mode0 --> mmc1_clk
> mux-mode4 --> gpio120
> mux-mode7 --> safe mode
>
> For the OMAP3530 CBC package you will find the same options on N19 and  
> for the CUS package the same options on ball M23.
>
> I have been doing a bit more looking at this and we do need to becareful  
> here. I think that we really need to view the OMAP3430 as a superset of  
> the OMAP3530. One example being, with the OMAP3530 I don't see support  
> for peripherals such as DSI, CSI, and MS. Hence, muxing options for the  
> signals corresponding to these peripherals are not shown in the OMAP3530  
> data manual.
>
> This just means that there are less muxing options on some of the balls  
> for the OMAP3530, but the good news is that there will not be any  
> conflicts between the OMAP3430 and OMAP3530 as far as muxing goes.

Sounds good. We also need to consider the number of MMC data lines
used for muxing, that's available as wires from the board-*.c files.

>>> OK, good.  Thanks for the clarification.
>>>
>>> Tony and I were thinking a few weeks back that we should drop the ball
>>> names from these mux options anyways as they don't really add any
>>> value, and seem to add more confusion.  Sounds like it's the right
>>> thing to do in this context.
>
> I was thinking this too. For different applications different packages  
> make sense. So this is fairly common to see. So dropping the ball name  
> would make this easier.
>
> I guess the only benefit is knowing the actual ball that you are using  
> for hardware purposes. However, on OMAP2/3 the register names imply what  
> is mux-mode0 and so it fairly easy to figure out the ball number from  
> the data manual.

Yeah let's plan on making that change.

Tony
