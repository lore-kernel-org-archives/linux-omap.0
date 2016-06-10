From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v10 08/14] usb: otg: add OTG/dual-role core
Date: Fri, 10 Jun 2016 10:04:29 +0300
Message-ID: <575A667D.4090007@ti.com>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com>
 <1465376626-30122-9-git-send-email-rogerq@ti.com> <57592060.6060801@ti.com>
 <2522343c-422f-79e1-af40-eb953bde42f6@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2522343c-422f-79e1-af40-eb953bde42f6@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, peter.chen@freescale.com
Cc: balbi@kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Sergei,

On 09/06/16 15:34, Sergei Shtylyov wrote:
> On 6/9/2016 10:53 AM, Roger Quadros wrote:
> 
>> It provides APIs for the following tasks
>>
>> - Registering an OTG/dual-role capable controller
>> - Registering Host and Gadget controllers to OTG core
>> - Providing inputs to and kicking the OTG state machine
>>
>> Provide a dual-role device (DRD) state machine.
>> DRD mode is a reduced functionality OTG mode. In this mode
>> we don't support SRP, HNP and dynamic role-swap.
>>
>> In DRD operation, the controller mode (Host or Peripheral)
>> is decided based on the ID pin status. Once a cable plug (Type-A
>> or Type-B) is attached the controller selects the state
>> and doesn't change till the cable in unplugged and a different
>> cable type is inserted.
>>
>> As we don't need most of the complex OTG states and OTG timers
>> we implement a lean DRD state machine in usb-otg.c.
>> The DRD state machine is only interested in 2 hardware inputs
>> 'id' and 'b_sess_vld'.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> [...]
> 
>> diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
>> new file mode 100644
>> index 0000000..baebe5c
>> --- /dev/null
>> +++ b/drivers/usb/common/usb-otg.c
>> @@ -0,0 +1,833 @@
> [...]
>> +/**
>> + * Change USB protocol when there is a protocol change.
>> + * fsm->lock must be held.
>> + */
> 
>    If you're using the kernel-doc comment, please follow the rules.
> 

All your comments are valid and I'll fix the issues.

<snip>

> [...]
> 
>    Phew, that was a long patch... normally I don't review the patches that are such big. :-)

Thanks for the patience and review :)
