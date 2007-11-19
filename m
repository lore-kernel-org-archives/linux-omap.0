From: Felipe Balbi <me@felipebalbi.com>
Subject: RE: [RFC patch] ARM: OMAP: Fix typo in drivers/usb/musb/Kconfig
Date: Mon, 19 Nov 2007 06:59:37 -0600
Message-ID: <b1e3167e56f8c32a258ab8054d4fb8e4@felipebalbi.com>
References: <010C7BAE6783F34D9AC336EE5A01A08804DC0849@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08804DC0849@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, 19 Nov 2007 18:23:38 +0530, "Gadiyar, Anand" <gadiyar@ti.com>
wrote:
> Hi, 
> 
>> We don't have ARCH_OMAP343X. Change to ARCH_OMAP34XX
>> 
>> Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
>> ---
>>  drivers/usb/musb/Kconfig |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
>> index 2e030b9..c795b01 100644
>> --- a/drivers/usb/musb/Kconfig
>> +++ b/drivers/usb/musb/Kconfig
>> @@ -30,7 +30,7 @@ config USB_MUSB_SOC
>>  	depends on USB_MUSB_HDRC
>>  	default y if ARCH_DAVINCI
>>  	default y if ARCH_OMAP2430
>> -	default y if ARCH_OMAP343X
>> +	default y if ARCH_OMAP34XX
>>  	help
>>  	  Use a static <asm/arch/hdrc_cnf.h> file to describe how the
>>  	  controller is configured (endpoints, mechanisms, etc) on the
>> @@ -43,7 +43,7 @@ comment "OMAP 243x high speed USB support"
>>  	depends on USB_MUSB_HDRC && ARCH_OMAP2430
>>  
>>  comment "OMAP 343x high speed USB support"
>> -	depends on USB_MUSB_HDRC && ARCH_OMAP343X
>> +	depends on USB_MUSB_HDRC && ARCH_OMAP34XX
>>  
>>  config USB_TUSB6010
>>  	boolean "TUSB 6010 support"
>> @@ -145,7 +145,7 @@ config MUSB_PIO_ONLY
>>  config USB_INVENTRA_DMA
>>  	bool
>>  	depends on USB_MUSB_HDRC && !MUSB_PIO_ONLY
>> -	default ARCH_OMAP2430 || ARCH_OMAP343X
>> +	default ARCH_OMAP2430 || ARCH_OMAP34XX
>>  	help
>>  	  Enable DMA transfers using Mentor's engine.
>>  
>>

you're also working on OMAP3's USB??
can we share code?? I have an almost working board-3430sdp-usb.c

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com
