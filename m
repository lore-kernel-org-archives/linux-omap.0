From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 1/9] usb: dwc3: add dual-role support
Date: Mon, 7 Sep 2015 12:42:52 +0300
Message-ID: <55ED5C1C.7080408@ti.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-2-git-send-email-rogerq@ti.com>
 <20150902143149.GD8299@saruman.tx.rr.com> <55E83B5C.7050001@ti.com>
 <20150903154444.GA4031@saruman.tx.rr.com> <55E95F14.20901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55E95F14.20901-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 04/09/15 12:06, Roger Quadros wrote:
> Felipe,
> 
> On 03/09/15 18:44, Felipe Balbi wrote:
>> Hi,
> 
>> On Thu, Sep 03, 2015 at 03:21:48PM +0300, Roger Quadros wrote:
>>>>> +	dwc->fsm->id = id;
>>>>> +	dwc->fsm->b_sess_vld = vbus;
>>>>> +	usb_otg_sync_inputs(dwc->fsm);
>>>>> +}
>>>>> +
>>>>> +static int dwc3_drd_start_host(struct otg_fsm *fsm, int on)
>>>>> +{
>>>>> +	struct device *dev = usb_otg_fsm_to_dev(fsm);
>>>>> +	struct dwc3 *dwc = dev_get_drvdata(dev);
>>>>
>>>> how about adding a usb_otg_get_drvdata(fsm) ?
>>>
>>> You meant for otg core? That can be done.
> 
>> yeah. BTW, I think otg core needs quite a few changes to become actually
>> useful. Currently it's just too much pointer ping-pong going back and
>> forth between phy, otg core, udc and hcd.
> 
> Sure, any inputs for improvement appreciated.
> 
> 
>> Also, I caught a ton of issues with it and suspend/resume. You might
>> want to fix them before adding more users to it.
> 
> OK.
> 
> 
>> It's also rather racy and that needs fixing too. On top of all that, I
>> think there's too much being added to UDC just to get Dual-Role, let's
>> see if we can improve that too.
> 
> Would appreciate if you could give all your inputs on the otg core thread
> as early as you can :)
> 
> 
>>>>> @@ -843,6 +998,16 @@ static int dwc3_probe(struct platform_device *pdev)
>>>>>  	hird_threshold = 12;
>>>>>  
>>>>>  	if (node) {
>>>>> +		if (of_property_read_bool(node, "extcon"))
>>>>> +			dwc->edev = extcon_get_edev_by_phandle(dev, 0);
>>>>> +		else if (of_property_read_bool(dev->parent->of_node, "extcon"))
>>>>> +			dwc->edev = extcon_get_edev_by_phandle(dev->parent, 0);
>>>>
>>>> why do you need to check the parent ? Why isn't that done on the glue
>>>> layer ?
>>>
>>> On DRA7-evm, the extcon device is defined in the glue layer node. But
>>> we need the device both at the glue layer and at the core layer.
> 
>> why do you need extcon here ? Glue updates core via UTMI about the
>> states, right ? So you should get proper VBUS and ID status via OTG IRQ.
>> Is that not working ?
> 
> I didn't even expect that would work. Let me give that a try.
> 
> 
>>> We do get the extcon device in dwc3-omap.c
>>>
>>> Any suggestion how to pass the extcon device from glue layer to core.c?
>>> Or should I add the extcon property to dwc3 USB node as well in the DT?
> 
>> GPIO toggles
>>   dwc3-omap extcon event
>>     update status via UTMI STATUS register
>>       OTG IRQ on core
>>         Horray!
> 
>> :-)
> 
> That's great. Thanks :)

This approach worked. Had to do the following change to the dwc3-omap glue
to make it work.

From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Date: Fri, 4 Sep 2015 15:13:59 +0300
Subject: [PATCH] usb: dwc3: omap: Pass VBUS and ID events transparently

Don't make any decisions regarding VBUS session based on ID
status. That is best left to the OTG core.

Pass ID and VBUS events independent of each other so that OTG
core knows exactly what to do.

This makes dual-role with extcon work with OTG irq on OMAP platforms.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
- ---
 drivers/usb/dwc3/dwc3-omap.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index b18f2a3..751feee 100644
- --- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -233,19 +233,14 @@ static void dwc3_omap_set_mailbox(struct dwc3_omap *omap,
 		}
 
 		val = dwc3_omap_read_utmi_ctrl(omap);
- -		val &= ~(USBOTGSS_UTMI_OTG_CTRL_IDDIG
- -				| USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
- -				| USBOTGSS_UTMI_OTG_CTRL_SESSEND);
- -		val |= USBOTGSS_UTMI_OTG_CTRL_SESSVALID
- -				| USBOTGSS_UTMI_OTG_CTRL_POWERPRESENT;
+		val &= ~USBOTGSS_UTMI_OTG_CTRL_IDDIG;
 		dwc3_omap_write_utmi_ctrl(omap, val);
 		break;
 
 	case OMAP_DWC3_VBUS_VALID:
 		val = dwc3_omap_read_utmi_ctrl(omap);
 		val &= ~USBOTGSS_UTMI_OTG_CTRL_SESSEND;
- -		val |= USBOTGSS_UTMI_OTG_CTRL_IDDIG
- -				| USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
+		val |= USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
 				| USBOTGSS_UTMI_OTG_CTRL_SESSVALID
 				| USBOTGSS_UTMI_OTG_CTRL_POWERPRESENT;
 		dwc3_omap_write_utmi_ctrl(omap, val);
@@ -254,14 +249,16 @@ static void dwc3_omap_set_mailbox(struct dwc3_omap *omap,
 	case OMAP_DWC3_ID_FLOAT:
 		if (omap->vbus_reg)
 			regulator_disable(omap->vbus_reg);
+		val = dwc3_omap_read_utmi_ctrl(omap);
+		val |= USBOTGSS_UTMI_OTG_CTRL_IDDIG;
+		dwc3_omap_write_utmi_ctrl(omap, val);
 
 	case OMAP_DWC3_VBUS_OFF:
 		val = dwc3_omap_read_utmi_ctrl(omap);
 		val &= ~(USBOTGSS_UTMI_OTG_CTRL_SESSVALID
 				| USBOTGSS_UTMI_OTG_CTRL_VBUSVALID
 				| USBOTGSS_UTMI_OTG_CTRL_POWERPRESENT);
- -		val |= USBOTGSS_UTMI_OTG_CTRL_SESSEND
- -				| USBOTGSS_UTMI_OTG_CTRL_IDDIG;
+		val |= USBOTGSS_UTMI_OTG_CTRL_SESSEND;
 		dwc3_omap_write_utmi_ctrl(omap, val);
 		break;
 
- -- 
2.1.4
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV7VwcAAoJENJaa9O+djCTlNEP/1ymxHQuTvTRupMB+WsGf/Md
DhgI9SAPNK8luElKYZMNIs7r+QyjoASubEmRqSjGrj7BtrXfLKwFNjktse+6x32l
ELjWgmMvU9BnO2vrrPXFafhoF42ywdqtB/3bVGfqTNubMZArI4QeXy8VWdQVPmTg
CoEl65Ta3nNyji0T0yXzklak7/cSJ1lU/RcBPQVJHc8FSmxD6EtM1U51QilojrtC
mtYfMzVpS1yTfvhnmwYLBip09eBTWRmgWPsQd7Y6uABJzFb02x6Q0Jd36SeaD6d8
jfowOa4FZ29mrUTi5tKGfHxgc2ZiD81vhFUdUJtgnlfc30rNEVNJDF8YtYEKHe5q
JQy7zCXRHX0XB+qwbs9RfFzDLNvSmot1cDuf78SPYbG/SR84txklBoTdA0rLKE82
xTU2l5ZPHJL6NULvte0KsR/OVwqtAnvB1xZ/o3HPrKfW7HBpfGkumVVOqE2bTRA0
5QrOrI9Txyjl+aAL4Tt15F8NM0w6m9mpbfJMXOY7gQM/2t3LbSfSeh8/P9sw3qxn
z0+tZ2cFXIm4o7zNtrKzXU3qWBvD7FDQ3m2Gev3WhrIUZMjrpVk5/6r8FXIJcPEs
46+vPD7BC48r7jAgqDA2rJRaq78PyUAkQ9oZssIqPZMPhS1ABtPFUshuxRJZd60A
ey0RU5H6TZDOHEQN0tW5
=+73W
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
