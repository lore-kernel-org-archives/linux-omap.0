From: Petr Kulhavy <petr@barix.com>
Subject: Re: Serious memory leak in TI EDMA driver (drivers/dma/edma.c)
Date: Fri, 20 Mar 2015 22:53:44 +0100
Message-ID: <550C96E8.5080603@barix.com>
References: <55072E56.7050802@barix.com> <5508205D.7010106@ti.com> <55087A3A.6070300@barix.com> <55098414.9020301@ti.com> <5509EF23.8080404@barix.com> <550C27C3.10406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36687 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbbCTVxt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2015 17:53:49 -0400
Received: by wgra20 with SMTP id a20so99835972wgr.3
        for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2015 14:53:48 -0700 (PDT)
In-Reply-To: <550C27C3.10406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org

Hi Peter,

yes, that is one of the differences to the EVM that the SD card is on=20
MMCSD1. This is due to the pin multiplexer and other peripherals we're=20
using.

Your patch is correct, however the edma_callback()  is using the channe=
l=20
number parameter for debug messages only. For the actual work=20
echan->ch_num is used. BTW is that correct? Could there be a mismatch=20
between the echan->ch_num and the ch_num parameter?

Something else seems to be odd in edma_alloc_chan_resources():

/* Alloc channel resources */
static int edma_alloc_chan_resources(struct dma_chan *chan)
{
         struct edma_chan *echan =3D to_edma_chan(chan);
         struct device *dev =3D chan->device->dev;
         int ret;
         int a_ch_num;
         LIST_HEAD(descs);

         a_ch_num =3D edma_alloc_channel(echan->ch_num, edma_callback,
                                         chan, EVENTQ_DEFAULT);


The third parameter to edma_alloc_channel() should be echan, not chan,=20
since the edma_callback() interprets the callback data parameter as=20
struct edma_chan *.

Let me know if you find something or if you have an advice for more deb=
ug.

Cheers
Petr



On 20.03.2015 14:59, Peter Ujfalusi wrote:
> Petr,
>
> On 03/18/2015 11:33 PM, Petr Kulhavy wrote:
>> Hi Peter,
>>
>> Yes, we do not use DT.
>> Our board design is very close to the da850evm reference board. So i=
f you have
>> a chance of getting hold of it you could try on that one.
> I have been trying to reproduce this on my OMAP-L138-EVM (da850evm) b=
ut was
> not able.
>
> There is a big difference in your an my setup: the MMC on my EVM is c=
onnected
> to MMC/SD0 interface while in your setup it seams to be connected to =
MMC/SD1.
> The DMA requests for MMC/SD0 is eDMA CC0 16/17, while the MMC/SD1 is =
eDMA CC1
> 28/29.
> So they are handled by different channel controllers. I would not rul=
e out
> that the support for the second CC has issues.
> The information from you logs just points to this direction also:
> You are writing to the MMC, so CC1 ch29 is active most of the time.
> In your log the channel number sometimes 65565 ((1 << 16) | 29) somet=
imes it
> is 29. In my case it is 17 every time.
> I think there is something funny regarding to how these channels on C=
C1 are
> working and this might be causing the leak for you.
>
> Unfortunately I do not have HW where I could use any channel on CC1 s=
o I can
> not debug this further, but I'll look at the code to see if anything =
obvious
> stands out.
> And something does stand out:
> arch/arm/common/edma.c: dma_irq_handler()
> It calls the callback with a wrong interrupt number since it does not=
 take
> into account the different CC.
> Can you try something similar to see if it helps:
>
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 6c49887d326e..e1d413c61e9e 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -405,7 +405,8 @@ static irqreturn_t dma_irq_handler(int irq, void =
*data)
>   					BIT(slot));
>   			if (edma_cc[ctlr]->intr_data[channel].callback)
>   				edma_cc[ctlr]->intr_data[channel].callback(
> -					channel, EDMA_DMA_COMPLETE,
> +					EDMA_CTLR_CHAN(ctlr, channel),
> +					EDMA_DMA_COMPLETE,
>   					edma_cc[ctlr]->intr_data[channel].data);
>   		}
>   	} while (sh_ipr);
>

--=20


--=20
Petr Kulhavy, MSc
System Architect

*BARIX*

petr@barix.com <mailto:petr@barix.com> | Skype: brain.barix

Barix AG, Seefeldstrasse 303 | 8008 Zurich, Switzerland
T +41 43 43322 11 | www.barix.com <http://www.barix.com>

You have received this email because of your relationship Barix AG and=20
its affiliated companies. Barix AG and its affiliated companies do not=20
sell or exchange email addresses, or any other personal contact=20
information provided by you with any third parties. All email=20
distributions are managed and controlled by Barix AG and its affiliated=
=20
companies.
Barix AG, Seefeldstr. 303, 8008 Z=FCrich, Switzerland. Company Reg. No:=
=20
CH-020.3.023.869-8, VAT Reg. No: CHE-105.687.663.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
