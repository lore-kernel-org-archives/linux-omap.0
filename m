From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/3] OMAP: control: add functions for DSP boot address/mode
 control
Date: Mon, 11 Oct 2010 17:32:50 -0500
Message-ID: <4CB39092.4070303@ti.com>
References: <20101011203659.24425.2381.stgit@twilight.localdomain> <20101011203710.24425.94685.stgit@twilight.localdomain> <AANLkTimnQJxS_6PrgECeQFwEkNU=4-f5=bStWS-AtDcs@mail.gmail.com> <alpine.DEB.2.00.1010111449240.16871@utopia.booyaka.com> <20101011211616.GE25462@atomide.com> <alpine.DEB.2.00.1010111519410.16871@utopia.booyaka.com> <alpine.DEB.2.00.1010111604430.16871@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42657 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756672Ab0JKWc4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Oct 2010 18:32:56 -0400
In-Reply-To: <alpine.DEB.2.00.1010111604430.16871@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 10/11/2010 5:16 PM, Paul Walmsley wrote:
>
> 4. If the DSP uses a peripheral, such as a GPTIMER or a McBSP, DSPBridge
> needs to reserve that device with the rest of Linux so some other Linux
> code isn't using it or doesn't try to use it, causing conflicts with
> DSPBridge.  I guess the list that we need to worry about is in _tiomap.h
> as l4_peripheral_table[].

this is done by using dmtimer fwk, mcbsp are also requested using mcbsp 
code (however I think functions to enable/disable mcbsp clocks should be 
added to mcbsp fwk)... There is no code (that I'm aware of) to control 
wdt3 nor ssi so this is still there. I still have to review the code to 
find any place were the registers are written directly though.

The other peripherals, at the moment, doesn't have a direct interaction 
with bridge, although they might be interconnected to iva. I guess we 
can remove some of the mapped peripherals (like dsi, gpio, uart) and add 
them back on request and by implementing the code to request them on arm 
side.

- omar

