From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 03/16] mfd: omap-usb-tll: introduce and use mode_needs_tll()
Date: Wed, 21 Nov 2012 14:37:34 +0200
Message-ID: <50ACCB0E.5000607@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com> <1352990054-14680-4-git-send-email-rogerq@ti.com> <20121121115705.GE10216@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121121115705.GE10216-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/21/2012 01:57 PM, Felipe Balbi wrote:
> On Thu, Nov 15, 2012 at 04:34:01PM +0200, Roger Quadros wrote:
>> This is a handy macro to check if the port requires the
>> USB TLL module or not. Use it to Enable the TLL module and manage
>> the clocks.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/mfd/omap-usb-tll.c |   20 ++++++++++++--------
>>  1 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
>> index 943ac14..7054395e 100644
>> --- a/drivers/mfd/omap-usb-tll.c
>> +++ b/drivers/mfd/omap-usb-tll.c
>> @@ -99,6 +99,10 @@
>>  
>>  #define is_ehci_tll_mode(x)	(x == OMAP_EHCI_PORT_MODE_TLL)
>>  
>> +/* only PHY and UNUSED modes don't need TLL */
>> +#define mode_needs_tll(x)	((x != OMAP_USBHS_PORT_MODE_UNUSED) && \
> 
> prepend with omap_usb_

OK.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
