From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 09/12] usb: gadget: udc: adapt to OTG core
Date: Thu, 28 Apr 2016 15:22:34 +0300
Message-ID: <5722008A.3020902@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-10-git-send-email-rogerq@ti.com>
 <AM4PR04MB2130ACE0588E64EA723987E3896E0@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <571E23D7.5070501@ti.com>
 <AM4PR04MB2130B0F024C0B275514020DE89630@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <5720A106.1030702@ti.com> <5721DDE5.7060708@ti.com>
 <AM4PR04MB213098D1AD7E63D227AD23B289650@AM4PR04MB2130.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM4PR04MB213098D1AD7E63D227AD23B289650@AM4PR04MB2130.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jun Li <jun.li@nxp.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "peter.chen@freescale.com" <peter.chen@freescale.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jun.li@freescale.com" <jun.li@freescale.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>, "abrestic@chromium.org" <abrestic@chromium.org>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On 28/04/16 13:23, Jun Li wrote:
> Hi
>=20
>> -----Original Message-----
>> From: Roger Quadros [mailto:rogerq@ti.com]
>> Sent: Thursday, April 28, 2016 5:55 PM
>> To: Jun Li <jun.li@nxp.com>; stern@rowland.harvard.edu; balbi@kernel=
=2Eorg;
>> gregkh@linuxfoundation.org; peter.chen@freescale.com
>> Cc: dan.j.williams@intel.com; jun.li@freescale.com;
>> mathias.nyman@linux.intel.com; tony@atomide.com; Joao.Pinto@synopsys=
=2Ecom;
>> abrestic@chromium.org; r.baldyga@samsung.com; linux-usb@vger.kernel.=
org;
>> linux-kernel@vger.kernel.org; linux-omap@vger.kernel.org
>> Subject: Re: [PATCH v6 09/12] usb: gadget: udc: adapt to OTG core
>>
>> Hi,
>>
>> On 27/04/16 14:22, Roger Quadros wrote:
>>> On 26/04/16 03:07, Jun Li wrote:
>>>> Hi
>>>>
>>>>> -----Original Message-----
>>>>> From: Roger Quadros [mailto:rogerq@ti.com]
>>>>> Sent: Monday, April 25, 2016 10:04 PM
>>>>> To: Jun Li <jun.li@nxp.com>; stern@rowland.harvard.edu;
>>>>> balbi@kernel.org; gregkh@linuxfoundation.org;
>>>>> peter.chen@freescale.com
>>>>> Cc: dan.j.williams@intel.com; jun.li@freescale.com;
>>>>> mathias.nyman@linux.intel.com; tony@atomide.com;
>>>>> Joao.Pinto@synopsys.com; abrestic@chromium.org;
>>>>> r.baldyga@samsung.com; linux-usb@vger.kernel.org;
>>>>> linux-kernel@vger.kernel.org; linux-omap@vger.kernel.org
>>>>> Subject: Re: [PATCH v6 09/12] usb: gadget: udc: adapt to OTG core
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 21/04/16 09:38, Jun Li wrote:
>>>>>> Hi,
>>>>>>
>>>>>> ...
>>>>>>>
>>>>>>>  /**
>>>>>>> + * usb_gadget_start - start the usb gadget controller and conn=
ect
>>>>>>> +to bus
>>>>>>> + * @gadget: the gadget device to start
>>>>>>> + *
>>>>>>> + * This is external API for use by OTG core.
>>>>>>> + *
>>>>>>> + * Start the usb device controller and connect to bus (enable =
pull).
>>>>>>> + */
>>>>>>> +static int usb_gadget_start(struct usb_gadget *gadget) {
>>>>>>> +	int ret;
>>>>>>> +	struct usb_udc *udc =3D NULL;
>>>>>>> +
>>>>>>> +	dev_dbg(&gadget->dev, "%s\n", __func__);
>>>>>>> +	mutex_lock(&udc_lock);
>>>>>>> +	list_for_each_entry(udc, &udc_list, list)
>>>>>>> +		if (udc->gadget =3D=3D gadget)
>>>>>>> +			goto found;
>>>>>>> +
>>>>>>> +	dev_err(gadget->dev.parent, "%s: gadget not registered.\n",
>>>>>>> +		__func__);
>>>>>>> +	mutex_unlock(&udc_lock);
>>>>>>> +	return -EINVAL;
>>>>>>> +
>>>>>>> +found:
>>>>>>> +	ret =3D usb_gadget_udc_start(udc);
>>>>>>> +	if (ret)
>>>>>>> +		dev_err(&udc->dev, "USB Device Controller didn't
>> start: %d\n",
>>>>>>> +			ret);
>>>>>>> +	else
>>>>>>> +		usb_udc_connect_control(udc);
>>>>>>
>>>>>> For drd, it's fine, but for real otg, gadget connect should be d=
one
>>>>>> by
>>>>>> loc_conn() instead of gadget start.
>>>>>
>>>>> It is upto the OTG state machine to call gadget_start() when it
>>>>> needs to connect to the bus (i.e. loc_conn()). I see no point in
>>>>> calling gadget start before.
>>>>>
>>>>> Do you see any issue in doing so?
>>>>
>>>> This is what OTG state machine does:
>>>> case OTG_STATE_B_PERIPHERAL:
>>>>      otg_chrg_vbus(otg, 0);
>>>>      otg_loc_sof(otg, 0);
>>>>      otg_set_protocol(fsm, PROTO_GADGET);
>>>>      otg_loc_conn(otg, 1);
>>>>      break;
>>
>> On second thoughts, after seen the OTG state machine.
>> otg_set_protocol(fsm, PROTO_GADGET); is always followed by
>> otg_loc_conn(otg, 1); And whenever protocol changes to anything othe=
r the
>> PROTO_GADGET, we use otg_loc_conn(otg, 0);
>>
>> So otg_loc_conn seems redundant. Can we just get rid of it?
>>
>> usb_gadget_start() implies that gadget controller starts up and enab=
les
>> pull.
>> usb_gadget_stop() implies that gadget controller disables pull and s=
tops.
>>
>>
>> Can you please explain why just these 2 APIs are not sufficient for =
full
>> OTG?
>>
>> Do we want anything to happen between gadget controller start/stop a=
nd
>> pull on/off?
>=20
> "loc_conn" is a standard output parameter in OTG spec, it deserves
> a separate api, yes, current implementation of OTG state machine code
> seems allow you to combine the 2 things into one, but don't do that,
> because they do not always happen together, e.g. for peripheral only
> B device (also a part OTG spec: section 7.3), will be fixed in gadget
> mode, but it will do gadget connect and disconnect in its diff states=
,
> so, to make the framework common, let's keep them separated.

I'm sorry but I didn't understand your comment about "it will do gadget
connect and disconnect in its diff states"

I am reading the OTG v2.0 specification and loc_conn is always true whe=
n
b_peripheral or a_peripheral is true and false otherwise.

loc_conn is just an internal state variable and it corresponds to our g=
adget_start/stop() state.

As per 7.4.2.3
"loc_conn
The =93local connect=94 (loc_conn) variable is TRUE when the local devi=
ce has signaled that it is connected to
the bus. This variable is FALSE when the local device has signaled that=
 it is disconnected from the bus"

Can you please point me in the specification if there is any place wher=
e loc_conn
is false and b_peripheral/a_peripheral is true?

cheers,
-roger
