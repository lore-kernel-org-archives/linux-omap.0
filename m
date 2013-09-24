From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFCv2 3/3] ARM: dts: N900: Add SSI information
Date: Tue, 24 Sep 2013 13:55:51 -0600
Message-ID: <5241EE47.5050907@wwwdotorg.org>
References: <1379277856-24571-1-git-send-email-sre@debian.org> <1379277856-24571-4-git-send-email-sre@debian.org> <5240A617.1010208@wwwdotorg.org> <20130923234656.GB24781@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130923234656.GB24781-SfvFxonMDyemK9LvCR3Hrw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/23/2013 05:46 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Sep 23, 2013 at 02:35:35PM -0600, Stephen Warren wrote:
>> On 09/15/2013 02:44 PM, Sebastian Reichel wrote:
>>> Add SSI device tree data for OMAP34xx and Nokia N900.

...
>>> +- ti,hwmods:		Name of the hwmod associated to the controller,
>>> which +			is "ssi".
>> 
>> I don't think we should add any more of that, for new bindings.
> 
> That basically means not adding new drivers until hwmod is
> completly removed, since no new drivers not using DT are accepted
> anymore.
> 
> hwmod still holds some information, which are not yet mapped to
> DT.

Tony, is defining hwmod properties for new OMAP bindings what everyone
is currently doing? I'm not sure how that will work with a stable DT
ABI...

I wonder if it makes sense not to define the ti,hwmods property in the
binding document (so it doesn't become part of the ABI), but put it
into the DTS file simply to make the current Linux code work? I'm not
sure if that's any better though.

>>> +Required Port sub-node properties: +- compatible:		Should be
>>> set to the following value +
>>> ti,omap3-ssi-port (applicable to OMAP34xx devices)
>> 
>> Hmm. Is it really the case that there is 1 controller with n
>> ports?
> 
> Yes with n=2.
> 
>> Are the ports really dependent upon some shared resource?
> 
> Yes and runtime power management.
> 
>> Couldn't the ports be represented as separate top-level SSI 
>> controllers?
> 
> Maybe with some phandles. The current layout is cleaner IMHO. The
> ports are part of the controller and actually most boards only use
> one of them.
> 
> In the original driver only the controller hat platform data with
> memory areas called "port1_rx" etc.

If the HW block really does include 2 ports, then representing it as a
single node in DT is fine; I was just making sure.

>>> +- interrupts:		Contains the interrupt information for the
>>> port. +- interrupt-names:	Contains the names of the interrupts.
>>> It's expected, +			that "mpu_irq0" and "mpu_irq1" are
>>> provided.
>> 
>> What exactly are those interrupts? "MPU" sounds like an external 
>> micro-controller/processor...
>> 
>>> +- ti,ssi-cawake-gpio:	Defines which GPIO pin is used to
>>> signify CAWAKE +			events for the port. This is an optional
>>> board-specific +			property. If it's missing the port will not
>>> be +			enabled.
>> 
>> That also sounds like something that's a higher-level protocol,
>> rather than whatever low-level transport "SSI" implements. Should
>> this be part of a child node that represents the device attached
>> to the SSI controller?
> 
> Both the interrupts and the cawake-gpio are used as irqs for 
> starting data transfers. As far as I understand it none of them are
> specific to the attached device.

But are the interrupts and GPIO actually part of the HSI protocol
itself, or something layered on top? While your particular board has
them wired up, is it strictly necessary for all boards using HSI to
have those IRQs/GPIOs?

>> Does the SSI controller (or its ports) not need any clocks,
>> resets, regulators, ...?
> 
> The only other stuff needed is taken care of by hwmod, which can be
> seen in this patch:
> 
> https://lkml.org/lkml/2013/9/15/97

It would be best to completely define the DT binding so that all
required clocks etc. are already present in the DT. That way, the DT
ABI won't change once people stop using hwmods. Tony, is that possible
on OMAP at present, irrespective of whether those e.g. clock
properties will actually be used by Linux?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
