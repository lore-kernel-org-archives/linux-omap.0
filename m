From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 2/2] pwm: Add PWM polarity flag macros for DT
Date: Fri, 12 Jul 2013 08:40:07 -0600
Message-ID: <51E01547.4030204@wwwdotorg.org>
References: <1373553468-6564-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1373553468-6564-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <51DEEE15.7040801@wwwdotorg.org> <3211864.2dENa1E110@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <3211864.2dENa1E110@avalon>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris BREZILLON <linux-arm-ZNYIgs0QAGpBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Philip Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/12/2013 04:41 AM, Laurent Pinchart wrote:
> Hi Stephen,
> 
> On Thursday 11 July 2013 11:40:37 Stephen Warren wrote:
>> On 07/11/2013 08:37 AM, Laurent Pinchart wrote:
>>> Define PWM_POLARITY_NORMAL and PWM_POLARITY_INVERTED macros in
>>> include/dt-bindings/pwm/pwm.h to be used by device tree sources.
>>>
>>>  Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt |  6 +++---
>>>  Documentation/devicetree/bindings/pwm/pwm-samsung.txt   |  5 +++--
>>>  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt  |  5 +++--
>>>  Documentation/devicetree/bindings/pwm/pwm.txt           |  8 +++++---
>>>  Documentation/devicetree/bindings/pwm/vt8500-pwm.txt    |  5 +++--
>>>  arch/arm/boot/dts/am335x-evm.dts                        |  3 ++-
>>>  arch/arm/boot/dts/am335x-evmsk.dts                      |  3 ++-
>>>  arch/arm/boot/dts/wm8850-w70v2.dts                      |  3 ++-
>>>  include/dt-bindings/pwm/pwm.h                           | 15 ++++++++++++
>>>  include/linux/pwm.h                                     |  4 ++--
>>
>> I think this needs to be separate patches; at least the new pwm.h should
>> be introduced separately to the board-specific *.dts edits, and perhaps
>> further split up?
> 
> What about splitting it in three patches that
> 
> - add the include/dt-bindings/pwm/pwm.h header, and update include/linux/pwm.h 
> and Documentation/devicetree/bindings/pwm/pwm.txt
> 
> - update the rest of the documentation
> 
> - update the .dts files

I think that sounds reasonable.

>> That way, the one patch that introduces <dt-bindings/pwm.h> would be
>> available to be merged into any other tree that wanted to take patches
>> to use the new defines.
>>
>>> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
>>>
>>>  enum pwm_polarity {
>>>
>>> -	PWM_POLARITY_NORMAL,
>>> -	PWM_POLARITY_INVERSED,
>>> +	PWM_POLARITY_NORMAL = 0,
>>> +	PWM_POLARITY_INVERSED = 1,
>>>
>>>  };
>>
>> Rather than manually editing that to ensure the enum matches the DT bindings
>> header, the whole point of making a separate <dt-bindings/...> directory was
>> that drivers could include the binding header files directly to avoid having
>> to duplicate the constant definitions. Can't <linux/pwm.h> include <dt-
>> bindings/pwm.h> and remove that enum?
> 
> We could do that, but we would then need to modify all drivers to replace 
> enum_pwm_polarity with unsigned int. Thierry, what's your opinion on this ?

Or perhaps we could keep the enums around, but force the values to match
the DT constants:

enum pwm_polarity {
	PWM_POLARITY_NORMAL = PWM_POLARITY_NORMAL,
	PWM_POLARITY_INVERTED = PWM_POLARITY_INVERTED,
};

(although obviously you'd need to avoid the enum and DT constants having
the same name).

Although this brings up one point: let's say we support ACPI/.. bindings
in the future. The enum possibly can't match the binding values from
every different kind of binding definition (DT, ACPI, ...) so perhaps
rather than changing the enum definition in <linux/pwm.h>, what we
should be doing is mapping between the different name-spaces in whatever
of_xlate function exists for the PWM flags cell. That would be more
flexible.
