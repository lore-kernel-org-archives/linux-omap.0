From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM][PATCH 2/4] OMAP3: Serial: Errata i202: fix for MDR1 access
Date: Fri, 9 Apr 2010 12:21:02 -0500
Message-ID: <4BBF61FE.3060807@ti.com>
References: <1270749249-14041-1-git-send-email-nm@ti.com> <1270749249-14041-2-git-send-email-nm@ti.com> <1270749249-14041-3-git-send-email-nm@ti.com> <4BBF5D14.1040803@ti.com> <FCCFB4CDC6E5564B9182F639FC3560870304A6595E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58590 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab0DIRVM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Apr 2010 13:21:12 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870304A6595E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kattungal, Deepak" <deepak.k@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Raja, Govindraj" <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>

Kattungal, Deepak had written, on 04/09/2010 12:06 PM, the following:
[..]
>> +	/* TX and RX FIFO Clear; FIFO dis */
>> +	serial_write_reg(p, UART_FCR, 0xA6);
> NAK
> Late realization: should be checking if FIFO clear actually occurred 
> before proceeding (FIFO clear bits will be cleared by h/w once it is 
> complete,
> so need to add a
> /* wait till  TX and RX fifos are cleard by h/w */
> while(serial_read_reg(p, UART_FCR) & 0x06)
> 	;
> 
> Deepak : The FCR is a Write-Only Register, the read to it wont return the correct value. If at all we need to add a check, 
 >the LSR should be read for the status of the FIFO. The same follows 
for the below section also.

Gee thx. Since RX fifo empty bit is 0 when empty and tx_fifo_empty bit 
is 1 when empty, i will change to:
while( 0x20 != (serial_read_reg(p, UART_LSR) & 0x21))
  	;
Also From errata it does not require to make sure that shift register 
also needs to be empty.. we could save a few nano seconds by not using that.

-- 
Regards,
Nishanth Menon
