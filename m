From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 1/9] usb: dwc3: add dual-role support
Date: Fri, 4 Sep 2015 12:06:28 +0300
Message-ID: <55E95F14.20901@ti.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-2-git-send-email-rogerq@ti.com>
 <20150902143149.GD8299@saruman.tx.rr.com> <55E83B5C.7050001@ti.com>
 <20150903154444.GA4031@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150903154444.GA4031@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Felipe,

On 03/09/15 18:44, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Sep 03, 2015 at 03:21:48PM +0300, Roger Quadros wrote:
>>>> +	dwc->fsm->id = id;
>>>> +	dwc->fsm->b_sess_vld = vbus;
>>>> +	usb_otg_sync_inputs(dwc->fsm);
>>>> +}
>>>> +
>>>> +static int dwc3_drd_start_host(struct otg_fsm *fsm, int on)
>>>> +{
>>>> +	struct device *dev = usb_otg_fsm_to_dev(fsm);
>>>> +	struct dwc3 *dwc = dev_get_drvdata(dev);
>>>
>>> how about adding a usb_otg_get_drvdata(fsm) ?
>>
>> You meant for otg core? That can be done.
> 
> yeah. BTW, I think otg core needs quite a few changes to become actually
> useful. Currently it's just too much pointer ping-pong going back and
> forth between phy, otg core, udc and hcd.

Sure, any inputs for improvement appreciated.

> 
> Also, I caught a ton of issues with it and suspend/resume. You might
> want to fix them before adding more users to it.

OK.

> 
> It's also rather racy and that needs fixing too. On top of all that, I
> think there's too much being added to UDC just to get Dual-Role, let's
> see if we can improve that too.

Would appreciate if you could give all your inputs on the otg core thread
as early as you can :)

> 
>>>> @@ -843,6 +998,16 @@ static int dwc3_probe(struct platform_device *pdev)
>>>>  	hird_threshold = 12;
>>>>  
>>>>  	if (node) {
>>>> +		if (of_property_read_bool(node, "extcon"))
>>>> +			dwc->edev = extcon_get_edev_by_phandle(dev, 0);
>>>> +		else if (of_property_read_bool(dev->parent->of_node, "extcon"))
>>>> +			dwc->edev = extcon_get_edev_by_phandle(dev->parent, 0);
>>>
>>> why do you need to check the parent ? Why isn't that done on the glue
>>> layer ?
>>
>> On DRA7-evm, the extcon device is defined in the glue layer node. But
>> we need the device both at the glue layer and at the core layer.
> 
> why do you need extcon here ? Glue updates core via UTMI about the
> states, right ? So you should get proper VBUS and ID status via OTG IRQ.
> Is that not working ?

I didn't even expect that would work. Let me give that a try.

> 
>> We do get the extcon device in dwc3-omap.c
>>
>> Any suggestion how to pass the extcon device from glue layer to core.c?
>> Or should I add the extcon property to dwc3 USB node as well in the DT?
> 
> GPIO toggles
>   dwc3-omap extcon event
>     update status via UTMI STATUS register
>       OTG IRQ on core
>         Horray!
> 
> :-)

That's great. Thanks :)

> 
>>>> +
>>>> +		if (IS_ERR(dwc->edev)) {
>>>> +			dev_vdbg(dev, "couldn't get extcon device\n");
>>>
>>> dev_err() ??
>>
>> Is it ok to print it even in EPROBE_DEFER case?
> 
> hmm, probably pointless, indeed.
> 

cheers,
- -roger
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV6V8UAAoJENJaa9O+djCToUwP/1SRrcUG/1KG54c1loxKFvYG
51x17TiVuQc68xtrp56HYJNRpZzZIwBqlfa3LU19bd/p6alYGaaY6jOqW+gFWWt8
tJd+7lyjVuCWkrJBQ6obK4yDPK4r6ZLcFlCTLGsfnd6SSBdsGxNrpcNCwz2rhhE/
uTPQdU4wvgxDFnGFVtTMhM+/ehtJtkKB4dppoFA5Vw86vsKinJ7o5EJMwho/PwJu
4D+mQVi17kQDBx1wkQPBxyVHD6RXfjMBLK+zg46T6lsg1eUodkv22Grf9Xy4i4wT
9Pr3g6SFnczkKiU1Bp7q4TV048SY0KedA7oe1U7K9B+hjHK4Fc2/vxtb3kGyNK7x
VPkN3NbvqSZalcgmdoDnv6VvU5NdnZUyKasVeJQDp9Fzaom9rUmNvic0ZLx9TOTP
4e4R2ovyCFnU1nODDUccYDInPiJ3EUo6D7CX3L7rfud5h6qAXcqC6vzZ3oHcSnBu
S1PXPTjLyk/a+den4gf41ReF5xKXzNocH21cXe7oFwKDaCJ9VgEn4+E5tX0vK778
KGHz3qFEQGkM6Eib0tEZEdHUEgeO8H99rNAELFNTrtS0FPZIEtQPHr2lmFDM/iYC
sEECc/HFP+LvmAzuJLA4XRUeNh6xo0K/ZDOtX1YOCCqnjy/UHNKvB4gUDzVaNti+
DB0wWXP+/A9Qz1PBK1dG
=rFBL
-----END PGP SIGNATURE-----
