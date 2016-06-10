From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 13/14] usb: gadget: udc: adapt to OTG core
Date: Fri, 10 Jun 2016 10:06:24 +0300
Message-ID: <575A66F0.4090307@ti.com>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com>
 <1465376626-30122-14-git-send-email-rogerq@ti.com>
 <SG2PR06MB09198DD132E005FFD4F4CAEED85F0@SG2PR06MB0919.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <SG2PR06MB09198DD132E005FFD4F4CAEED85F0-ESzmfEwOt/zNQ8RBPPB5A20DtJ1/0DrXvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org" <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org" <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, "jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "grygorii.strashko-l0cyMroinI0@public.gmane.org" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "nsekhar-l0cyMroinI0@public.gmane.org" <nsekhar-l0cyMroinI0@public.gmane.org>, "b-liu-l0cyMroinI0@public.gmane.org" <b-liu-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Yoshihiro,

On 09/06/16 13:49, Yoshihiro Shimoda wrote:
> Hi Roger,
> 
>> From: Roger Quadros
>> Sent: Wednesday, June 08, 2016 6:04 PM
>>
>> The OTG state machine needs a mechanism to start and
>> stop the gadget controller as well as connect/disconnect
>> from the bus. Add usb_gadget_start(), usb_gadget_stop()
>> and usb_gadget_connect_control().
>>
>> Introduce usb_otg_add_gadget_udc() to allow controller drivers
>> to register a gadget controller that is part of an OTG instance.
>>
>> Register with OTG core when UDC is added in usb_add_gadget_udc_release()
>> and unregister on usb_del_gadget_udc().
>>
>> Notify the OTG core when gadget function driver is available on
>> udc_bind_to_driver() and when it is removed in usb_gadget_remove_driver().
>>
>> We need to unlock the usb_lock mutex before calling
>> usb_otg_register_gadget() else it will cause a circular
>> locking dependency.
>>
>> Ignore softconnect sysfs control when we're in OTG
>> mode as OTG FSM should care of gadget softconnect using
>> the b_bus_req mechanism.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/usb/gadget/udc/udc-core.c | 202 ++++++++++++++++++++++++++++++++++++--
>>  include/linux/usb/gadget.h        |   4 +
>>  2 files changed, 196 insertions(+), 10 deletions(-)
> 
> I tried to apply this patch on the Felipe's usb.git / testing/next branch,
> but I couldn't apply because the udc-core.c was renamed to core.c.
> https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=testing/next&id=a22b539c7082b6a3046b3a9cebb356a047a2d81d
> 
> I guess this patch needs rebase for that.

OK. I'll respin the whole series on Felipe's usb.git /testing/next.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
