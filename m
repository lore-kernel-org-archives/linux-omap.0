From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 00/11] USB: OTG/DRD Core functionality
Date: Fri, 17 Jul 2015 13:34:29 +0300
Message-ID: <55A8DA35.6040109@ti.com>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com>	<CAL1qeaEJ9uX1vgvwO4-ABdGi5C96HZ2jBYWeKiGHJ-uqv6ooGg@mail.gmail.com>	<55A65F98.203@ti.com> <CAL1qeaEkpUq3mzZXpr2gxceW3q_zHLspWUv9qxBP8q_1+_g-OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL1qeaEkpUq3mzZXpr2gxceW3q_zHLspWUv9qxBP8q_1+_g-OA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Bresticker <abrestic@chromium.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Chen <peter.chen@freescale.com>, Dan Williams <dan.j.williams@intel.com>, jun.li@freescale.com, Mathias Nyman <mathias.nyman@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Joao.Pinto@synopsys.com, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 16/07/15 21:29, Andrew Bresticker wrote:
> Hi Roger,
> 
> On Wed, Jul 15, 2015 at 6:26 AM, Roger Quadros <rogerq@ti.com> wrote:
>> Hi Andrew,
>>
>> On 13/07/15 22:14, Andrew Bresticker wrote:
>>> Hi Roger,
>>>
>>> On Wed, Jul 8, 2015 at 3:19 AM, Roger Quadros <rogerq@ti.com> wrote:
>>>> Usage model:
>>>> -----------
>>>>
>>>> - The OTG controller device is assumed to be the parent of
>>>> the host and gadget controller. It must call usb_otg_register()
>>>> before populating the host and gadget devices so that the OTG
>>>> core is aware that it is an OTG device before the host & gadget
>>>> register. The OTG controller must provide struct otg_fsm_ops *
>>>> which will be called by the OTG core depending on OTG bus state.
>>>
>>> I'm wondering if the requirement that the OTG controller be the parent
>>> of the USB host/device-controllers makes sense.  For some context, I'm
>>> working on adding dual-role support for Tegra210, specifically on a
>>> system with USB Type-C.  On Tegra, the USB host-controller and USB
>>> device-controller are two separate IP blocks (XUSB host and XUSB
>>> device) with another, separate, IP block (XUSB padctl) for the USB PHY
>>> and OTG support.  In the non-Type-C case, your OTG framework could
>>> work well, though it's debatable as to whether or not the XUSB padctl
>>> device should be a parent to the XUSB host/device-controller devices
>>> (currently it isn't - it's just a PHY provider).  But in the Type-C
>>> case, it's an off-chip embedded controller that determines the
>>> dual-role status of the Type-C port, so the above requirement doesn't
>>> make sense at all.
>>>
>>> My idea was to have the OTG/DRD controller explicitly specify its host
>>> and device controllers, so in DT, something like:
>>>
>>> otg-controller {
>>>     ...
>>>     device-controller = <&usb_device>;
>>>     host-controller = <&usb_host>;
>>>     ...
>>> };
>>>
>>> usb_device: usb-device@.... {
>>>     ...
>>> };
>>>
>>> usb_host: usb-host@... {
>>>     ...
>>> };
>>>
>>> What do you think?
>>
>> I agree that we need to support your use case but how to do it
>> is not yet clear to me.
>>
>> In your above example the otg controller knows what are the host
>> and gadget controllers but the host/gadget devices don't
>> know who is their otg controller.
>>
>> So the problem is that when usb_otg_register_hcd/gadget() is called
>> we need to get a handle to the otg controller.
>>
>> One solution I see is to iterate over the registered otg_controller_list
>> and check if we match the host/gadget controller in there.
>>
>> Then there is also a possibility that host/gadget controllers get
>> registered before the OTG controller. Then we can't know for sure if
>> the host/gadget controller was meant for dual-role operation or not
>> and it will resort to single role operation.
>>
>> Any idea to prevent the above situation?
>>
>> Maybe we need to add some logic in host/gadget cores to check if the port
>> is meant for dual-role use and defer probe if OTG controller is not yet
>> registered?
> 
> In the DT case, I think we could add an "otg-controller" property to
> the host and gadget nodes, and in usb_otg_register_{hcd,gadget}()
> check for that property and defer probe if the referenced OTG
> controller has not yet been registered.  Not sure how to indicate that
> a host/gadget is meant for dual-role operation on non-DT platforms
> though.
> 

Sounds fine for DT case.

For non DT case I don't see any other way to connect the OTG controller
to the host/gadget controllers other than the parent child relationship.

Maybe for non DT case we can still have that constraint.
We can have this constraint regardless so that DT users who fit
in that model don't need to add 'otg-controller' property.

cheers,
-roger
