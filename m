From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCHv2 1/3] OMAP UART: Add omap-serial driver support.
Date: Wed, 28 Oct 2009 14:32:28 +0200
Message-ID: <4AE839DC.7060906@nokia.com>
References: <35817.192.168.10.88.1256713979.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45221 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbZJ1Mc5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 08:32:57 -0400
In-Reply-To: <35817.192.168.10.88.1256713979.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Govindraj.R" <govindraj.raja@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

Govindraj.R wrote:
> This patch adds support for OMAP3430-HIGH SPEED UART Controller.
> 
> Signed-off-by: Govindraj R <govindraj.raja@ti.com>

Could you fix these checkpatch errors:

ERROR: need consistent spacing around '|' (ctx:VxW)
#477: FILE: drivers/serial/omap-serial.c:238:
+	} while ((lsr & (UART_LSR_DR| UART_LSR_BI)) && (max_count-- > 0));
  	                            ^

ERROR: space required after that ',' (ctx:VxV)
#1093: FILE: drivers/serial/omap-serial.c:854:
+	serial_out(up, UART_OMAP_WER,0x7f);
  	                            ^

WARNING: suspect code indent for conditional statements (8, 17)
#1719: FILE: drivers/serial/omap-serial.c:1480:
+	if (!uart->context_valid)
+		 return;

total: 2 errors, 1 warnings, 1975 lines checked

Thanks,

A.
