From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 07/11] usb: otg: add OTG core
Date: Fri, 14 Aug 2015 12:42:38 +0300
Message-ID: <55CDB80E.2030403@ti.com>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com> <1436350777-28056-8-git-send-email-rogerq@ti.com> <20150713021456.GE27710@shlinux2> <55A390FB.5080406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55A390FB.5080406@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Peter,

On 13/07/15 13:20, Roger Quadros wrote:
> On 13/07/15 05:14, Peter Chen wrote:
>> On Wed, Jul 08, 2015 at 01:19:33PM +0300, Roger Quadros wrote:
>>> The OTG core instantiates the OTG Finite State Machine
>>> per OTG controller and manages starting/stopping the
>>> host and gadget controllers based on the bus state.
>>>
>>> It provides APIs for the following tasks
>>>
>>> - Registering an OTG capable controller
>>> - Registering Host and Gadget controllers to OTG core
>>> - Providing inputs to and kicking the OTG state machine
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>>  MAINTAINERS                  |   4 +-
>>>  drivers/usb/Kconfig          |   2 +-
>>>  drivers/usb/Makefile         |   1 +
>>>  drivers/usb/common/Makefile  |   3 +-
>>>  drivers/usb/common/usb-otg.c | 768 +++++++++++++++++++++++++++++++++++++++++++
>>>  drivers/usb/common/usb-otg.h |  71 ++++
>>>  drivers/usb/core/Kconfig     |  11 +-
>>>  include/linux/usb/otg.h      |  91 ++++-
>>>  8 files changed, 930 insertions(+), 21 deletions(-)
>>>  create mode 100644 drivers/usb/common/usb-otg.c
>>>  create mode 100644 drivers/usb/common/usb-otg.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 8133cef..b21278e 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -10640,12 +10640,14 @@ S:	Maintained
>>>  F:	Documentation/usb/ohci.txt
>>>  F:	drivers/usb/host/ohci*
>>>  
>>> -USB OTG FSM (Finite State Machine)
>>> +USB OTG/DRD core and FSM (Finite State Machine)
>>>  M:	Peter Chen <Peter.Chen@freescale.com>
>>> +M:	Roger Quadros <rogerq@ti.com>
>>>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
>>>  L:	linux-usb@vger.kernel.org
>>>  S:	Maintained
>>>  F:	drivers/usb/common/usb-otg-fsm.c
>>> +F:	drivers/usb/common/usb-otg.c
>>>  
>>>  USB OVER IP DRIVER
>>>  M:	Valentina Manea <valentina.manea.m@gmail.com>
>>> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
>>> index 8ed451d..5b625e2 100644
>>> --- a/drivers/usb/Kconfig
>>> +++ b/drivers/usb/Kconfig
>>> @@ -32,7 +32,7 @@ if USB_SUPPORT
>>>  config USB_COMMON
>>>  	tristate
>>>  	default y
>>> -	depends on USB || USB_GADGET
>>> +	depends on USB || USB_GADGET || USB_OTG
>>>  
>>
>> USB_OTG can depends on USB || UB_GADGET?
> 
> I didn't understand. The above is for USB_COMMON.
> 
>>
>>>  config USB_ARCH_HAS_HCD
>>>  	def_bool y
>>> diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
>>> index d8926c6..769d13b 100644
>>> --- a/drivers/usb/Makefile
>>> +++ b/drivers/usb/Makefile
>>> @@ -60,5 +60,6 @@ obj-$(CONFIG_USB_RENESAS_USBHS)	+= renesas_usbhs/
>>>  obj-$(CONFIG_USB_GADGET)	+= gadget/
>>>  
>>>  obj-$(CONFIG_USB_COMMON)	+= common/
>>> +obj-$(CONFIG_USB_OTG)		+= common/
>>>  
>>
>> The comment like above.
> 
> What should it look like?
> 

Can you please clarify what you meant at the above two
comments? Thanks.

cheers,
-roger
