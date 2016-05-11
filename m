From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 10/14] usb: otg: add hcd companion support
Date: Wed, 11 May 2016 17:13:19 +0300
Message-ID: <57333DFF.3090609@ti.com>
References: <1462191537-10314-1-git-send-email-rogerq@ti.com>
 <1462191537-10314-11-git-send-email-rogerq@ti.com>
 <20160504131700.GA20184@rob-hp-laptop> <5729FD66.4020704@ti.com>
 <20160511135426.GA25762@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160511135426.GA25762@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
Cc: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 11/05/16 16:54, Rob Herring wrote:
> On Wed, May 04, 2016 at 04:47:18PM +0300, Roger Quadros wrote:
>> On 04/05/16 16:17, Rob Herring wrote:
>>> On Mon, May 02, 2016 at 03:18:53PM +0300, Roger Quadros wrote:
>>>> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>>>>
>>>> Since some host controller (e.g. EHCI) needs a companion host controller
>>>> (e.g. OHCI), this patch adds such a configuration to use it in the OTG
>>>> core.
>>>>
>>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/usb/generic.txt |  3 +++
>>>>  drivers/usb/common/usb-otg.c                      | 32 ++++++++++++++++-------
>>>>  include/linux/usb/otg.h                           |  7 ++++-
>>>>  3 files changed, 32 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
>>>> index f6866c1..1db1c33 100644
>>>> --- a/Documentation/devicetree/bindings/usb/generic.txt
>>>> +++ b/Documentation/devicetree/bindings/usb/generic.txt
>>>> @@ -27,6 +27,9 @@ Optional properties:
>>>>   - otg-controller: phandle to otg controller. Host or gadget controllers can
>>>>  			contain this property to link it to a particular OTG
>>>>  			controller.
>>>> + - hcd-needs-companion: must be present if otg controller is dealing with
>>>> +			EHCI host controller that needs a companion OHCI host
>>>> +			controller.
>>>
>>> Don't you need to have a link to the companion controller node?
>>
>> primary and companion controllers are totally independent of each other
>> e.g. EHCI and OHCI. They are enabled by separate Kconfig options and
>> the system can operate with either or both of them enabled.
>>
>> At the OTG layer we don't have information as to whether we should be waiting
>> for both of them to register or not and hence need this "hcd-needs-companion" flag.
> 
> What I mean is if you have 2 EHCI controllers with 2 companion 
> controllers, don't you need to know which companion goes with which EHCI 
> controller? Just like you do for the otg-controller property.
> 

That is a very good point. I'm not very sure and it seems that current code won't work
with multiple EHCI + companion instances.

Alan, does USB core even know which EHCI and OHCI are linked to the same port
or the handoff is software transparent?

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
