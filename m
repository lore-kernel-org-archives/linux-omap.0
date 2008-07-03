From: "Girish S G" <girishsg@ti.com>
Subject: Re: [PATCH 2/2] ARM:OMAP2: irda support 3430
Date: Thu, 3 Jul 2008 15:01:41 +0530
Message-ID: <006301c8dcef$9b362310$5cf6180a@ent.ti.com>
References: <63619.192.168.10.89.1215067554.squirrel@dbdmail.itg.ti.com> <5d5443650807030158o728c1d85p5062525d9c2a7a1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53972 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754709AbYGCL6X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jul 2008 07:58:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap@vger.kernel.org

----- Original Message ----- 
From: "Trilok Soni" <soni.trilok@gmail.com>

>> +static struct omap_irda_config irda_data = {
>> +       .transceiver_cap        = IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
>> +       .transceiver_mode       = transceiver_mode,
>> +       .select_irda            = select_irda,
>
>
> Please rename this hooks to 3430sdp_transceiver_mode and
> 3430sdp_select_irda. Check board_h4.c for example.
>
I think it can be made irda_transceiver_mode/irda_select.  And, as this is in 3430 board file, prefixing it with 3430sdp serves no 
purpose i guess.


>> +       .rx_channel             = OMAP24XX_DMA_UART3_RX,
>> +       .tx_channel             = OMAP24XX_DMA_UART3_TX,
>> +       .dest_start             = OMAP_UART3_BASE,
>> +       .src_start              = OMAP_UART3_BASE,
>> +       .tx_trigger             = OMAP24XX_DMA_UART3_TX,
>> +       .rx_trigger             = OMAP24XX_DMA_UART3_RX,
>> +};
>
> Actually rx_channel to rx_trigger are not platform data and it is long
> pending cleanup. It would great if we can convert this to
> platform_resource, as it is chip specific not board specific.
>
Yes, I agree.


-girish 

