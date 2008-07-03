From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 2/2] ARM:OMAP2: irda support 3430
Date: Thu, 3 Jul 2008 15:05:58 +0530
Message-ID: <5d5443650807030235j7a09742k60a94e23c611caf4@mail.gmail.com>
References: <63619.192.168.10.89.1215067554.squirrel@dbdmail.itg.ti.com>
	 <5d5443650807030158o728c1d85p5062525d9c2a7a1e@mail.gmail.com>
	 <006301c8dcef$9b362310$5cf6180a@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:62945 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877AbYGCMWv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 08:22:51 -0400
Received: by ug-out-1314.google.com with SMTP id h2so674987ugf.16
        for <linux-omap@vger.kernel.org>; Thu, 03 Jul 2008 05:22:48 -0700 (PDT)
In-Reply-To: <006301c8dcef$9b362310$5cf6180a@ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Girish S G <girishsg@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Girish,

On Thu, Jul 3, 2008 at 3:01 PM, Girish S G <girishsg@ti.com> wrote:
> ----- Original Message ----- From: "Trilok Soni" <soni.trilok@gmail.com>
>
>>> +static struct omap_irda_config irda_data = {
>>> +       .transceiver_cap        = IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
>>> +       .transceiver_mode       = transceiver_mode,
>>> +       .select_irda            = select_irda,
>>
>>
>> Please rename this hooks to 3430sdp_transceiver_mode and
>> 3430sdp_select_irda. Check board_h4.c for example.
>>
> I think it can be made irda_transceiver_mode/irda_select.  And, as this is
> in 3430 board file, prefixing it with 3430sdp serves no purpose i guess.
>

I am leaving this decision to you. I am more interested in moving the
platform data members below as platform resource and also changing the
same for all the boards :)

>
>>> +       .rx_channel             = OMAP24XX_DMA_UART3_RX,
>>> +       .tx_channel             = OMAP24XX_DMA_UART3_TX,
>>> +       .dest_start             = OMAP_UART3_BASE,
>>> +       .src_start              = OMAP_UART3_BASE,
>>> +       .tx_trigger             = OMAP24XX_DMA_UART3_TX,
>>> +       .rx_trigger             = OMAP24XX_DMA_UART3_RX,
>>> +};
>>
>> Actually rx_channel to rx_trigger are not platform data and it is long
>> pending cleanup. It would great if we can convert this to
>> platform_resource, as it is chip specific not board specific.
>>
> Yes, I agree.
>
>
> -girish
>



-- 
---Trilok Soni
http://triloksoni.wordpress.com
