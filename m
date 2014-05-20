From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: gpmc: enable wait-pin monitoring for NAND
 devices via DT
Date: Tue, 20 May 2014 10:38:04 +0300
Message-ID: <537B065C.4080502@ti.com>
References: <1400267276-16001-1-git-send-email-pekon@ti.com> <CABxcv=k7KZAwsP-oW_8k_bZRtMLToCy904kq7Xv=c0da465w2A@mail.gmail.com> <20980858CB6D3A4BAE95CA194937D5E73EACE25C@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59270 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbaETHiL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 03:38:11 -0400
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EACE25C@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tony Lindgren <tony@atomide.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap <linux-omap@vger.kernel.org>

On 05/19/2014 09:26 PM, Gupta, Pekon wrote:
> Hi Javier,
> 
>> From: Javier Martinez Canillas [mailto:javier@dowhile0.org]
>>
>> Hello Pekon,
>>
>> On Fri, May 16, 2014 at 9:07 PM, Pekon Gupta <pekon@ti.com> wrote:
>>> This patch enables 'wait-pin' monitoring in NAND driver if following properties
>>> are present under NAND DT node
>>>         gpmc,wait-pin = <wait-pin number>
>>>         gpmc,wait-on-read;
>>>         gpmc,wait-on-write;
>>> As NAND generic framework uses common path nand_chip->dev_ready() for monitoring
>>> completion of Read and Write status, so wait-pin monitoring is enabled only when
>>> both 'gpmc,wait-on-read' and 'gpmc,wait-on-write' are specified.
>>>
>>
>> I see that the GPMC driver checks if "gpmc,wait-pin" property is
>> defined and only in that case tries to read both "gpmc,wait-on-read"
>> and "gpmc,wait-on-write" and prints a "read/write wait monitoring not
>> enabled!" warning if one of those is not defined.
>>
>> So my question is, it's a requirement and these 3 properties need to
>> always be defined together?  If that is the case then I wonder why
>> there are 3 different properties and why not just defining
>> "gpmc,wait-pin" implies "gpmc,wait-on-{read,write}" ?
>>
> GPMC as a hardware engine allows selection of wait-pin independently
> for both Read and Write paths, but NAND generic framework uses single
> common function nand_chip->dev_ready() which is used for both
> Read and Write paths to poll wait-pin. 
> So, in case of NAND both 'gpmc,wait-on-read' and 'gpmc,wait-on-write'
> should be simultaneously defined to enable wait-pin monitoring. 
> 
> But GPMC being generic hardware engine for NOR, OneNAND and other
> parallel interfaces like Camera, Ethernet the two separate bindings allow
> flexibility to use wait-pin monitoring for only one of the paths {Read | Write}.
> 
> Therefore this check is added in gpmc_nand_init(), and not in gpmc_read_settings_dt()
> which is common for all type of GPMC devices (NAND, NOR, .. )

The behavior of wait pin is slightly different when it is a NAND device when compared to other NOR like devices. On NAND, the pin is not used for inserting wait states in the bus access cycle, but instead it is used for waiting for the device to be ready after a particular command. So this wait logic must be implemented in the NAND driver software. GPMC will only forward the wait pin state via a status register, or at best give you an interrupt.

For NAND use case, the GPMC hardware WAIT pin monitoring logic needs to be disabled (see NOTE in section 10.1.5.14.2 NAND Device-Ready Pin). The NAND driver only needs to know which wait pin the NAND chips device ready is connected to so that it can monitor it via the GPMC.STATUS register. The current omap_dev_ready() is so fragile that it will break if NAND device is not on CS0.

cheers,
-roger
