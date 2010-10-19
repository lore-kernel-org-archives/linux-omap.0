From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v2 2/6] TI816X: Update common omap platform files
Date: Tue, 19 Oct 2010 15:14:12 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B035685E764@dbde02.ent.ti.com>
References: <1281546658-11437-1-git-send-email-hemantp@ti.com>
 <20100916223037.GT29610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44218 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab0JSJoS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 05:44:18 -0400
In-Reply-To: <20100916223037.GT29610@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Tony Lindgren wrote on Friday, September 17, 2010 4:01 AM:

> * Hemant Pedanekar <hemantp@ti.com> [100811 10:03]:
>> --- a/arch/arm/plat-omap/include/plat/serial.h
>> +++ b/arch/arm/plat-omap/include/plat/serial.h
>> @@ -51,6 +51,11 @@
>>  #define OMAP4_UART3_BASE	0x48020000
>>  #define OMAP4_UART4_BASE	0x4806e000
>> 
>> +/* TI816X serial ports */
>> +#define TI816X_UART1_BASE	0x48020000
>> +#define TI816X_UART2_BASE	0x48022000
>> +#define TI816X_UART3_BASE	0x48024000
>> +
>>  /* External port on Zoom2/3 */
>>  #define ZOOM_UART_BASE		0x10000000
>>  #define ZOOM_UART_VIRT		0xfa400000
> 
> These defines should get added by the serial port patch in the series,
> currently 6/6. 
> 
> Tony

I have included them here because the common.c (part of this patch) requires 
UART base addresses in ti816x_globals while the same serial.h file is 
also part of patch 6 where TI816XUART definitions are used for LL DEBUG.  

Thanks
-
Hemant

