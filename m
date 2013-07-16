From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/2] pwm: Add PWM polarity flag macros for DT
Date: Tue, 16 Jul 2013 03:16:48 +0200
Message-ID: <6105968.TjP9HSeA1l@avalon>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20130712172441.GB9620@dhcp-172-17-186-34.nvidia.com> <51E03F9C.2060903@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:50860 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357Ab3GPBQG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jul 2013 21:16:06 -0400
In-Reply-To: <51E03F9C.2060903@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, Philip Avinash <avinashphilip@ti.com>, Boris BREZILLON <linux-arm@overkiz.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hello,

On Friday 12 July 2013 11:40:44 Stephen Warren wrote:
> On 07/12/2013 11:24 AM, Thierry Reding wrote:
> > On Fri, Jul 12, 2013 at 08:40:07AM -0600, Stephen Warren wrote:
> >> On 07/12/2013 04:41 AM, Laurent Pinchart wrote:
> >>> Hi Stephen,
> > 
> > [...]
> > 
> >>> What about splitting it in three patches that
> >>> 
> >>> - add the include/dt-bindings/pwm/pwm.h header, and update
> >>> include/linux/pwm.h and
> >>> Documentation/devicetree/bindings/pwm/pwm.txt
> >>> 
> >>> - update the rest of the documentation
> >>> 
> >>> - update the .dts files
> >> 
> >> I think that sounds reasonable.
> > 
> > Shouldn't the addition of include/dt-bindings/pwm/pwm.h be separate from
> > its inclusion in include/linux/pwm.h so that it can be moved more easily
> > (cherry-picked) to a separate repository?
> 
> I'm fine with that being another separate patch. However, I doubt cherry-
> picking is an issue here; when the separate DT repo is created, it seems
> likely that someone will simply copy the latest files from the latest Linux
> kernel in order to populate the tree. cherry-picking probably won't work
> because:
> 
> a) I doubt that the DT binding/header additions have always been kept
> separate from kernel code changes in all of Linux's history.
> 
> b) I wouldn't be remotely surprised if the layout of the new repo was
> entirely different to the kernel source tree layout, so direct cherry-pick
> wouldn't work.
> 
> c) Not having a common git history would make adding a kernel remote into
> the DT repo rather odd.
> 
> (b) and (c)  would at leat require some kind of git filter operation rather
> than cherry-pick, and this issue could be solve in that filter definition.

I agree with the reasoning, so I'll implement the patch split scheme described 
above unless someone objects.

> >>>>> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> >>>>> 
> >>>>> enum pwm_polarity {
> >>>>> 
> >>>>> -	PWM_POLARITY_NORMAL, -	PWM_POLARITY_INVERSED, +
> >>>>> PWM_POLARITY_NORMAL = 0, +	PWM_POLARITY_INVERSED = 1,
> >>>>> 
> >>>>> };
> >>>> 
> >>>> Rather than manually editing that to ensure the enum matches the DT
> >>>> bindings header, the whole point of making a separate <dt-bindings/...>
> >>>> directory was that drivers could include the binding header files
> >>>> directly to avoid having to duplicate the constant definitions. Can't
> >>>> <linux/pwm.h> include <dt- bindings/pwm.h> and remove that enum?
> >>> 
> >>> We could do that, but we would then need to modify all drivers to
> >>> replace enum_pwm_polarity with unsigned int. Thierry, what's your
> >>> opinion on this ?
> >> 
> >> Or perhaps we could keep the enums around, but force the values to match
> >> the DT constants:
> >> 
> >> enum pwm_polarity { PWM_POLARITY_NORMAL = PWM_POLARITY_NORMAL,
> >> PWM_POLARITY_INVERTED = PWM_POLARITY_INVERTED, };
> >> 
> >> (although obviously you'd need to avoid the enum and DT constants having
> >> the same name).
> > 
> > I think I've seen stuff like the following done in a few header files to
> > keep compatibility between enums and defines.
> > 
> > enum foo { BAR, #define BAR BAR BAZ, #define BAZ BAZ };
> > 
> > Which, as I understand it, won't work in this case because DTC can only
> > cope with plain cpp files?
> 
> Yeah, dtc doesn't understand "enum", so you can't include an enum definition
> in a DT file. You have to share simple #define headers between DT and kernel
> code.
> 
> >> Although this brings up one point: let's say we support ACPI/..
> >> bindings in the future. The enum possibly can't match the binding
> >> values from every different kind of binding definition (DT, ACPI,
> >> ...) so perhaps rather than changing the enum definition in
> >> <linux/pwm.h>, what we should be doing is mapping between the
> >> different name-spaces in whatever of_xlate function exists for
> >> the PWM flags cell. That would be more flexible.
> > 
> > I'm not quite sure what exactly you are suggesting here. Can you
> > elaborate?
> 
> Suppose ACPI (or whatever else) starts representing PWM devices. Suppose the
> author isn't aware that DT exists, represents PWM devices and/or has already
> defined some PWM-related flags. So, ACPI picks bit 5 in some data value to
> represent inverted, rather than bit 0. Then, there is no way that all of [
> (a) DT binding PWM flags (b) ACPI PWM flags (c) Linux's enum foo ] can use
> the same values. Hence, some mapping is required between them.
> 
> The typical way to do this is to define an "of_xlate" function which
> converts from DT cell values to Linux-internal representation. Presumably if
> we added an ACPI parser, there'd be some equivalent for that.
> 
> So, what I'm arguing for is that of_pwm_simple_xlate() (or any other custom
> xlate function) should include both <dt-bindings/pwm/pwm.h> and
> <linux/pwm.h>, and contain explicit code to convert between the two name-
> spaces of flags definitions. Since those two name-spaces currently are 100%
> identical, presumably if the code is written in the right way, the compiler
> will actually just optimize it all away...

If ACPI (or any other source of device information) uses different numerical 
values for the flags we will need an xlate function. In the DT case we're 
designing bindings so we're free to pick the numerical values currently used 
by the kernel, and even use the same symbolic names. I'm however fine with 
renamed the #define's in dt-bindings/pwm/pwm.h. Does anyone have a preference 
regarding the names I should use ?

-- 
Regards,

Laurent Pinchart

