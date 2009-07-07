From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: [PATCH] OMAP3: RX51: Define TWL4030 USB transceiver in board
 file
Date: Tue, 07 Jul 2009 09:37:50 +0300
Message-ID: <4A52ED3E.1020704@nokia.com>
References: <1246868531-5023-1-git-send-email-ext-roger.quadros@nokia.com> <20090706095140.GR8461@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:44582 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbZGGGjV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jul 2009 02:39:21 -0400
In-Reply-To: <20090706095140.GR8461@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Felipe Balbi wrote:
> On Mon, Jul 06, 2009 at 10:22:11AM +0200, Quadros Roger (EXT-Teleca/Helsinki) wrote:
> 
> please put some description here. Other than that:

ok. will send updated patch with description. thanks for your comment.

> 
>> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> 
>> ---
>>  arch/arm/mach-omap2/board-rx51-peripherals.c |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
>> index 9a0bf67..56d931a 100644
>> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
>> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
>> @@ -278,6 +278,10 @@ static struct twl4030_gpio_platform_data rx51_gpio_data = {
>>  	.setup			= rx51_twlgpio_setup,
>>  };
>>  
>> +static struct twl4030_usb_data rx51_usb_data = {
>> +	.usb_mode		= T2_USB_MODE_ULPI,
>> +};
>> +
>>  static struct twl4030_platform_data rx51_twldata = {
>>  	.irq_base		= TWL4030_IRQ_BASE,
>>  	.irq_end		= TWL4030_IRQ_END,
>> @@ -286,6 +290,7 @@ static struct twl4030_platform_data rx51_twldata = {
>>  	.gpio			= &rx51_gpio_data,
>>  	.keypad			= &rx51_kp_data,
>>  	.madc			= &rx51_madc_data,
>> +	.usb			= &rx51_usb_data,
>>  
>>  	.vaux1			= &rx51_vaux1,
>>  	.vaux2			= &rx51_vaux2,
>> -- 
>> 1.6.0.4
> 

