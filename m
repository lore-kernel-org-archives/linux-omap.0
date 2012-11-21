From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 05/16] mfd: omap-usb-tll: Add OMAP5 revision and HSIC
 support
Date: Wed, 21 Nov 2012 14:49:41 +0200
Message-ID: <50ACCDE5.9040505@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com> <1352990054-14680-6-git-send-email-rogerq@ti.com> <20121121121238.GG10216@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121121121238.GG10216-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/21/2012 02:12 PM, Felipe Balbi wrote:
> On Thu, Nov 15, 2012 at 04:34:03PM +0200, Roger Quadros wrote:
>> The TLL module on OMAP5 has 3 channels.
>> HSIC mode requires the TLL channel to be in Transparent UTMI mode.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/mfd/omap-usb-tll.c |   14 ++++++++++++++
>>  1 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
>> index 31ac7db..c48d545 100644
>> --- a/drivers/mfd/omap-usb-tll.c
>> +++ b/drivers/mfd/omap-usb-tll.c
>> @@ -54,10 +54,13 @@
>>  
>>  #define	OMAP_TLL_CHANNEL_CONF(num)			(0x040 + 0x004 * num)
>>  #define OMAP_TLL_CHANNEL_CONF_FSLSMODE_SHIFT		24
>> +#define OMAP_TLL_CHANNEL_CONF_DRVVBUS			(1 << 16)
>> +#define OMAP_TLL_CHANNEL_CONF_CHRGVBUS			(1 << 15)
>>  #define	OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF		(1 << 11)
>>  #define	OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE		(1 << 10)
>>  #define	OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE		(1 << 9)
>>  #define	OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE		(1 << 8)
>> +#define OMAP_TLL_CHANNEL_CONF_MODE_TRANSPARENT_UTMI	(2 << 1)
>>  #define OMAP_TLL_CHANNEL_CONF_CHANMODE_FSLS		(1 << 1)
>>  #define	OMAP_TLL_CHANNEL_CONF_CHANEN			(1 << 0)
>>  
>> @@ -96,6 +99,7 @@
>>  #define OMAP_USBTLL_REV1		0x00000015	/* OMAP3 */
>>  #define OMAP_USBTLL_REV2		0x00000018	/* OMAP 3630 */
>>  #define OMAP_USBTLL_REV3		0x00000004	/* OMAP4 */
>> +#define OMAP_USBTLL_REV4		0x6		/* OMAP5 */
> 
> looks wrong to me. Are you sure this is what that 32-bit register reads
> out ? Bits[31:30] should read as 0b01 as per internal documentation.
> 

Yes I'm pretty sure about that. I'm on 5432 though. Not sure if 5430
shows different.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
