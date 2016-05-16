From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v8 10/14] usb: otg: add hcd companion support
Date: Mon, 16 May 2016 11:12:26 +0300
Message-ID: <573980EA.10901@ti.com>
References: <1463133808-10630-1-git-send-email-rogerq@ti.com>
 <1463133808-10630-11-git-send-email-rogerq@ti.com>
 <CAL_JsqL+=Kx+1YLe4PpJ8Y9Ng0j0S_miVx5LALR4JFzdQvgY+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqL+=Kx+1YLe4PpJ8Y9Ng0j0S_miVx5LALR4JFzdQvgY+w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Peter Chen <peter.chen@freescale.com>, balbi@kernel.org, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Li Jun <jun.li@freescale.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>, Sekhar Nori <nsekhar@ti.com>, Bin Liu <b-liu@ti.com>, Linux USB List <linux-usb@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 13/05/16 21:13, Rob Herring wrote:
> On Fri, May 13, 2016 at 5:03 AM, Roger Quadros <rogerq@ti.com> wrote:
>> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>
>> Since some host controller (e.g. EHCI) needs a companion host controller
>> (e.g. OHCI), this patch adds such a configuration to use it in the OTG
>> core.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Acked-by: Peter Chen <peter.chen@nxp.com>
>> ---
>>  Documentation/devicetree/bindings/usb/generic.txt |  3 +++
>>  drivers/usb/common/usb-otg.c                      | 32 ++++++++++++++++-------
>>  include/linux/usb/otg.h                           |  7 ++++-
>>  3 files changed, 32 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
>> index f6866c1..1db1c33 100644
>> --- a/Documentation/devicetree/bindings/usb/generic.txt
>> +++ b/Documentation/devicetree/bindings/usb/generic.txt
>> @@ -27,6 +27,9 @@ Optional properties:
>>   - otg-controller: phandle to otg controller. Host or gadget controllers can
>>                         contain this property to link it to a particular OTG
>>                         controller.
>> + - hcd-needs-companion: must be present if otg controller is dealing with
>> +                       EHCI host controller that needs a companion OHCI host
>> +                       controller.
> 
> I thought the conclusion was this is not needed?

This is still needed to differentiate between primary+shared HCD case vs
primary + primary-companion HCD case.

> 
> One thing that is not clear here is otg-controller is a host or device
> property while hcd-needs-companion is an OTG controller property.
> These lists should be separated.

Agreed. I'll fix that up.

cheers,
-roger
