From: Thomas Weber <thomas@tomweber.eu>
Subject: Re: [PATCH] ARM: OMAP3: Devkit8000: Fix dvi output
Date: Mon, 19 Nov 2012 07:10:57 +0100
Message-ID: <50A9CD71.8080501@tomweber.eu>
References: <1353256083-19983-1-git-send-email-thomas@tomweber.eu> <50A9C909.1030006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 81-89-104-214.blue.kundencontroller.de ([81.89.104.214]:55339
	"EHLO tomweber.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab2KSGLA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Nov 2012 01:11:00 -0500
In-Reply-To: <50A9C909.1030006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org

Hello Tomi,

On 11/19/2012 06:52 AM, Tomi Valkeinen wrote:
> On 2012-11-18 18:28, Thomas Weber wrote:
>> Add i2c bus number for DVI output.
>> The driver uses this to detect if a panel is connected and to read EDID.
>>
>> Signed-off-by: Thomas Weber <thomas@tomweber.eu>
>> Cc: stable@vger.kernel.org #v3.5 v3.6
>> ---
>>   arch/arm/mach-omap2/board-devkit8000.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
>> index 1fd161e..73d3d8e 100644
>> --- a/arch/arm/mach-omap2/board-devkit8000.c
>> +++ b/arch/arm/mach-omap2/board-devkit8000.c
>> @@ -138,6 +138,7 @@ static struct omap_dss_device devkit8000_lcd_device = {
>>   };
>>   
>>   static struct tfp410_platform_data dvi_panel = {
>> +	.i2c_bus_num		= 1,
>>   	.power_down_gpio	= -1,
>>   };
> That change is already included in the "[PATCH] OMAP: board-files: fix
> i2c_bus for tfp410" path I sent on Friday.
>
>   Tomi
>
>
Thanks.

Thomas
