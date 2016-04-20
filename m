From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 06/12] usb: otg: get rid of CONFIG_USB_OTG_FSM in
 favour of CONFIG_USB_OTG
Date: Wed, 20 Apr 2016 11:12:40 +0300
Message-ID: <571739F8.4010804@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-7-git-send-email-rogerq@ti.com>
 <20160418080514.GG4477@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160418080514.GG4477-Fb7DQEYuewWctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 18/04/16 11:05, Peter Chen wrote:
> On Tue, Apr 05, 2016 at 05:05:11PM +0300, Roger Quadros wrote:
>> Let's use CONFIG_USB_OTG as a single config option to enable
>> USB OTG and the OTG FSM. This makes things a lot less confusing.
>>
>> Update all users of CONFIG_USB_OTG_FSM to CONFIG_USB_OTG.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  Documentation/usb/chipidea.txt | 2 +-
>>  drivers/usb/Makefile           | 1 +
>>  drivers/usb/chipidea/Makefile  | 2 +-
>>  drivers/usb/chipidea/ci.h      | 2 +-
>>  drivers/usb/chipidea/otg_fsm.h | 2 +-
>>  drivers/usb/common/Makefile    | 3 ++-
>>  drivers/usb/core/Kconfig       | 8 --------
>>  drivers/usb/phy/Kconfig        | 2 +-
>>  8 files changed, 8 insertions(+), 14 deletions(-)
>>
>> diff --git a/Documentation/usb/chipidea.txt b/Documentation/usb/chipidea.txt
>> index 678741b..3b1f263 100644
>> --- a/Documentation/usb/chipidea.txt
>> +++ b/Documentation/usb/chipidea.txt
>> @@ -5,7 +5,7 @@ with 2 Freescale i.MX6Q sabre SD boards.
>>  
>>  1.1 How to enable OTG FSM in menuconfig
>>  ---------------------------------------
>> -Select CONFIG_USB_OTG_FSM, rebuild kernel Image and modules.
>> +Select CONFIG_USB_OTG, rebuild kernel Image and modules.
>>  If you want to check some internal variables for otg fsm,
>>  mount debugfs, there are 2 files which can show otg fsm
>>  variables and some controller registers value:
>> diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
>> index dca7856..16a5b55 100644
>> --- a/drivers/usb/Makefile
>> +++ b/drivers/usb/Makefile
>> @@ -59,5 +59,6 @@ obj-$(CONFIG_USB_RENESAS_USBHS)	+= renesas_usbhs/
>>  obj-$(CONFIG_USB_GADGET)	+= gadget/
>>  
>>  obj-$(CONFIG_USB_COMMON)	+= common/
>> +obj-$(CONFIG_USB_OTG)		+= common/
> 
> Why we need to add above line?

It is not needed as USB_OTG can't be set without USB_COMMON.
I'll remove it.

cheers,
-roger

> 
> Peter
>>  
>>  obj-$(CONFIG_USBIP_CORE)	+= usbip/
>> diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
>> index 518e445..45aa24d 100644
>> --- a/drivers/usb/chipidea/Makefile
>> +++ b/drivers/usb/chipidea/Makefile
>> @@ -3,7 +3,7 @@ obj-$(CONFIG_USB_CHIPIDEA)		+= ci_hdrc.o
>>  ci_hdrc-y				:= core.o otg.o debug.o
>>  ci_hdrc-$(CONFIG_USB_CHIPIDEA_UDC)	+= udc.o
>>  ci_hdrc-$(CONFIG_USB_CHIPIDEA_HOST)	+= host.o
>> -ci_hdrc-$(CONFIG_USB_OTG_FSM)		+= otg_fsm.o
>> +ci_hdrc-$(CONFIG_USB_OTG)		+= otg_fsm.o
>>  
>>  # Glue/Bridge layers go here
>>  
>> diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
>> index c523975..1a32b8c 100644
>> --- a/drivers/usb/chipidea/ci.h
>> +++ b/drivers/usb/chipidea/ci.h
>> @@ -406,7 +406,7 @@ static inline u32 hw_test_and_write(struct ci_hdrc *ci, enum ci_hw_regs reg,
>>   */
>>  static inline bool ci_otg_is_fsm_mode(struct ci_hdrc *ci)
>>  {
>> -#ifdef CONFIG_USB_OTG_FSM
>> +#ifdef CONFIG_USB_OTG
>>  	struct usb_otg_caps *otg_caps = &ci->platdata->ci_otg_caps;
>>  
>>  	return ci->is_otg && ci->roles[CI_ROLE_HOST] &&
>> diff --git a/drivers/usb/chipidea/otg_fsm.h b/drivers/usb/chipidea/otg_fsm.h
>> index 6366fe3..2d451bb 100644
>> --- a/drivers/usb/chipidea/otg_fsm.h
>> +++ b/drivers/usb/chipidea/otg_fsm.h
>> @@ -64,7 +64,7 @@
>>  
>>  #define TB_AIDL_BDIS         (20)	/* 4ms ~ 150ms, section 5.2.1 */
>>  
>> -#if IS_ENABLED(CONFIG_USB_OTG_FSM)
>> +#if IS_ENABLED(CONFIG_USB_OTG)
>>  
>>  int ci_hdrc_otg_fsm_init(struct ci_hdrc *ci);
>>  int ci_otg_fsm_work(struct ci_hdrc *ci);
>> diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
>> index 6bbb3ec..f8f2c88 100644
>> --- a/drivers/usb/common/Makefile
>> +++ b/drivers/usb/common/Makefile
>> @@ -6,5 +6,6 @@ obj-$(CONFIG_USB_COMMON)	  += usb-common.o
>>  usb-common-y			  += common.o
>>  usb-common-$(CONFIG_USB_LED_TRIG) += led.o
>>  
>> -obj-$(CONFIG_USB_OTG_FSM) += usb-otg-fsm.o
>>  obj-$(CONFIG_USB_ULPI_BUS)	+= ulpi.o
>> +usbotg-y		:= usb-otg-fsm.o
>> +obj-$(CONFIG_USB_OTG)	+= usbotg.o
>> diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
>> index dd28010..ae228d0 100644
>> --- a/drivers/usb/core/Kconfig
>> +++ b/drivers/usb/core/Kconfig
>> @@ -75,14 +75,6 @@ config USB_OTG_BLACKLIST_HUB
>>  	  and software costs by not supporting external hubs.  So
>>  	  are "Embedded Hosts" that don't offer OTG support.
>>  
>> -config USB_OTG_FSM
>> -	tristate "USB 2.0 OTG FSM implementation"
>> -	depends on USB && USB_OTG
>> -	select USB_PHY
>> -	help
>> -	  Implements OTG Finite State Machine as specified in On-The-Go
>> -	  and Embedded Host Supplement to the USB Revision 2.0 Specification.
>> -
>>  config USB_ULPI_BUS
>>  	tristate "USB ULPI PHY interface support"
>>  	depends on USB_SUPPORT
>> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
>> index c690474..06794e2 100644
>> --- a/drivers/usb/phy/Kconfig
>> +++ b/drivers/usb/phy/Kconfig
>> @@ -20,7 +20,7 @@ config AB8500_USB
>>  
>>  config FSL_USB2_OTG
>>  	bool "Freescale USB OTG Transceiver Driver"
>> -	depends on USB_EHCI_FSL && USB_FSL_USB2 && USB_OTG_FSM && PM
>> +	depends on USB_EHCI_FSL && USB_FSL_USB2 && USB_OTG && PM
>>  	select USB_PHY
>>  	help
>>  	  Enable this to support Freescale USB OTG transceiver.
>> -- 
>> 2.5.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
