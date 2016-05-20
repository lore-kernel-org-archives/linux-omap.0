From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v8 08/14] usb: otg: add OTG/dual-role core
Date: Fri, 20 May 2016 12:19:07 +0300
Message-ID: <573ED68B.60907@ti.com>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-9-git-send-email-rogerq@ti.com> <57398C16.5050805@ti.com>
 <CAL411-qb0dHQrn+AarSApCq6L=toKPRerLKDcx_H+5WDWu_VDg@mail.gmail.com>
 <573C674A.7080302@ti.com> <573ECB74.8060502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <573ECB74.8060502@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Peter Chen <peter.chen@freescale.com>, balbi@kernel.org, tony@atomide.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 20/05/16 11:31, Roger Quadros wrote:
> On 18/05/16 15:59, Roger Quadros wrote:
>> Hi Peter,
>>
>> On 18/05/16 10:45, Peter Chen wrote:
>>>
>>>
>>> On Mon, May 16, 2016 at 5:00 PM, Roger Quadros <rogerq@ti.com <mailto:rogerq@ti.com>> wrote:
>>>
>>>     On 13/05/16 13:03, Roger Quadros wrote:
>>>     > It provides APIs for the following tasks
>>>     >
>>>     > - Registering an OTG/dual-role capable controller
>>>     > - Registering Host and Gadget controllers to OTG core
>>>     > - Providing inputs to and kicking the OTG state machine
>>>     >
>>>     > Provide a dual-role device (DRD) state machine.
>>>     > DRD mode is a reduced functionality OTG mode. In this mode
>>>     > we don't support SRP, HNP and dynamic role-swap.
>>>     >
>>>     > In DRD operation, the controller mode (Host or Peripheral)
>>>     > is decided based on the ID pin status. Once a cable plug (Type-A
>>>     > or Type-B) is attached the controller selects the state
>>>     > and doesn't change till the cable in unplugged and a different
>>>     > cable type is inserted.
>>>     >
>>>     > As we don't need most of the complex OTG states and OTG timers
>>>     > we implement a lean DRD state machine in usb-otg.c.
>>>     > The DRD state machine is only interested in 2 hardware inputs
>>>     > 'id' and 'b_sess_vld'.
>>>     >
>>>     > Signed-off-by: Roger Quadros <rogerq@ti.com <mailto:rogerq@ti.com>>
>>>     > ---
>>>     >  drivers/usb/common/Makefile  |    2 +-
>>>     >  drivers/usb/common/usb-otg.c | 1042 ++++++++++++++++++++++++++++++++++++++++++
>>>     >  drivers/usb/core/Kconfig     |    4 +-
>>>     >  include/linux/usb/gadget.h   |    2 +
>>>     >  include/linux/usb/hcd.h      |    1 +
>>>     >  include/linux/usb/otg-fsm.h  |    7 +
>>>     >  include/linux/usb/otg.h      |  154 ++++++-
>>>     >  7 files changed, 1206 insertions(+), 6 deletions(-)
>>>     >  create mode 100644 drivers/usb/common/usb-otg.c
>>>
>>>
>>>     This patch causes the following build issues when CONFIG_USB_GADGET=m, CONFIG_USB=m,
>>>     CONFIG_USB_COMMON=m and CONFIG_USB_OTG=y
>>>
>>>     ERROR: "usb_otg_register_gadget" [drivers/usb/gadget/udc/udc-core.ko] undefined!
>>>     ERROR: "usb_otg_unregister_gadget" [drivers/usb/gadget/udc/udc-core.ko] undefined!
>>>     ERROR: "usb_otg_register_hcd" [drivers/usb/core/usbcore.ko] undefined!
>>>     ERROR: "usb_otg_unregister_hcd" [drivers/usb/core/usbcore.ko] undefined!
>>>     ERROR: "otg_statemachine" [drivers/usb/chipidea/ci_hdrc.ko] undefined!
>>>     scripts/Makefile.modpost:91: recipe for target '__modpost' failed
>>>     make[1]: *** [__modpost] Error 1
>>>     Makefile:1141: recipe for target 'modules' failed
>>>     make: *** [modules] Error 2
>>>     make: *** Waiting for unfinished jobs....
>>>
>>>     drivers/built-in.o: In function `drd_set_state':
>>>     usb-otg.c:(.text+0x2b4242): undefined reference to `usb_otg_state_string'
>>>     drivers/built-in.o: In function `drd_statemachine':
>>>     (.text+0x2b4b4c): undefined reference to `usb_otg_state_string'
>>>     Makefile:937: recipe for target 'vmlinux' failed
>>>
>>>     I'll fix it up with the following diff.
>>>
>>>     diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
>>>     index dca7856..16a5b55 100644
>>>     --- a/drivers/usb/Makefile
>>>     +++ b/drivers/usb/Makefile
>>>     @@ -59,5 +59,6 @@ obj-$(CONFIG_USB_RENESAS_USBHS)       += renesas_usbhs/
>>>      obj-$(CONFIG_USB_GADGET)       += gadget/
>>>
>>>      obj-$(CONFIG_USB_COMMON)       += common/
>>>     +obj-$(CONFIG_USB_OTG)          += common/
>>>
>>>      obj-$(CONFIG_USBIP_CORE)       += usbip/
>>>     diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
>>>     index 77048aa..17e449e 100644
>>>     --- a/drivers/usb/common/usb-otg.c
>>>     +++ b/drivers/usb/common/usb-otg.c
>>>     @@ -56,6 +56,30 @@ static int usb_otg_hcd_is_primary_hcd(struct usb_hcd *hcd)
>>>             return hcd == hcd->primary_hcd;
>>>      }
>>>
>>>     +static const char *otg_state_string(enum usb_otg_state state)
>>>     +{
>>>     +       static const char *const names[] = {
>>>     +               [OTG_STATE_A_IDLE] = "a_idle",
>>>     +               [OTG_STATE_A_WAIT_VRISE] = "a_wait_vrise",
>>>     +               [OTG_STATE_A_WAIT_BCON] = "a_wait_bcon",
>>>     +               [OTG_STATE_A_HOST] = "a_host",
>>>     +               [OTG_STATE_A_SUSPEND] = "a_suspend",
>>>     +               [OTG_STATE_A_PERIPHERAL] = "a_peripheral",
>>>     +               [OTG_STATE_A_WAIT_VFALL] = "a_wait_vfall",
>>>     +               [OTG_STATE_A_VBUS_ERR] = "a_vbus_err",
>>>     +               [OTG_STATE_B_IDLE] = "b_idle",
>>>     +               [OTG_STATE_B_SRP_INIT] = "b_srp_init",
>>>     +               [OTG_STATE_B_PERIPHERAL] = "b_peripheral",
>>>     +               [OTG_STATE_B_WAIT_ACON] = "b_wait_acon",
>>>     +               [OTG_STATE_B_HOST] = "b_host",
>>>     +       };
>>>     +
>>>     +       if (state < 0 || state >= ARRAY_SIZE(names))
>>>     +               return "UNDEFINED";
>>>     +
>>>     +       return names[state];
>>>     +}
>>>     +
>>>
>>>
>>>
>>> From my point, make another copy for otg stuff is not a good way,
>>> could we make folder under usb/ named otg for dedicated otg stuffs,
>>> in that case, build otg stuffs can not depend on USB_COMMON.
>>
>> OK. I can try that. I'll delete otg_state_string from usb-common.c and
>> move it into usb/otg/usb-otg.c
>>
>> I'll also move usb-otg-fsm.c to usb/otg/.
> 
> But we can't delete usb_otg_state_string() from usb-common.c. That is used at a
> number of places whether OTG is enabled or not. 
> 
> One option is to make usb-common built in when otg is enabled. What do you say?
> 

This should also get solved if we make USB_OTG tristate so that it is same as
USB_COMMON.

However I haven't had success in making Kconfig behave like this.

USB_OTG = y if USB == y && GADGET = m
USB_OTG = y if USB == m && GADGET = y

Is there any Kconfig trickery to get this behaviour?

cheers,
-roger

> cheers,
> -roger
> 
>>>      /**
>>>       * Check if the OTG device is in our wait list and return
>>>       * otg_wait_data, else NULL.
>>>     @@ -433,7 +457,7 @@ static void drd_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
>>>
>>>             fsm->state_changed = 1;
>>>             dev_dbg(otg->dev, "otg: set state: %s\n",
>>>     -               usb_otg_state_string(new_state));
>>>     +               otg_state_string(new_state));
>>>             switch (new_state) {
>>>             case OTG_STATE_B_IDLE:
>>>                     drd_set_protocol(fsm, PROTO_UNDEF);
>>>     @@ -449,7 +473,7 @@ static void drd_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
>>>                     break;
>>>             default:
>>>                     dev_warn(otg->dev, "%s: otg: invalid state: %s\n",
>>>     -                        __func__, usb_otg_state_string(new_state));
>>>     +                        __func__, otg_state_string(new_state));
>>>                     break;
>>>             }
>>>
>>>     @@ -507,7 +531,7 @@ int drd_statemachine(struct usb_otg *otg)
>>>
>>>             default:
>>>                     dev_err(otg->dev, "%s: otg: invalid usb-drd state: %s\n",
>>>     -                       __func__, usb_otg_state_string(state));
>>>     +                       __func__, otg_state_string(state));
>>>                     break;
>>>             }
>>>
>>>     --
>>>     cheers,
>>>     -roger
>>>     --
>>>     To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>>>     the body of a message to majordomo@vger.kernel.org <mailto:majordomo@vger.kernel.org>
>>>     More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>>
>>> -- 
>>> BR,
>>> Peter Chen
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
