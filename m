From: "Girish. S. G." <girishsg@ti.com>
Subject: Re: [RFC][PATCH 1/1] serial: OMAP driver
Date: Thu, 21 Aug 2008 19:21:05 +0530 (IST)
Message-ID: <35015.192.168.10.89.1219326665.squirrel@dbdmail.itg.ti.com>
References: <45510.192.168.10.88.1217503495.squirrel@dbdmail.itg.ti.com>
    <fb249edb0808061747s4d55a8a0y72f51c2d08bce236@mail.gmail.com>
Reply-To: girishsg@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38897 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758284AbYHUNvO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Aug 2008 09:51:14 -0400
In-Reply-To: <fb249edb0808061747s4d55a8a0y72f51c2d08bce236@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andrzej zaborowski <balrogg@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

> Hi,
>
> 2008/7/31 Girish. S. G. <girishsg@ti.com>:
>> Serial driver for OMAP Uart controllers
>>
>> Signed-off-by: Girish S G <girishsg@ti.com>
>> ---

>> +       /* Reset the UART */
>> +       serial_out(up, UART_OMAP_MDR1, 0x07);
>> +       serial_out(up, UART_OMAP_SCR, 0x08);
>> +       serial_out(up, UART_OMAP_MDR1, 0x00);
>> +       serial_out(up, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
>
> Should this also work on older OMAPs? (The Kconfig allows building on omap1)
> OMAP15xx didn't have the SYSC register, instead MDR1 resets the
> module. I haven't checked the other registers used in this driver.

That's good point. I don't have OMAP15xx and it would definitely help full if
somebody in community validate it. I will send the patch with your comment
included.

Regards,
Girish

