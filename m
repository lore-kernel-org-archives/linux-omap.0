From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 00/10] usb: phy: cleanups to Kconfig and directories
Date: Fri, 15 Mar 2013 14:50:51 -0600
Message-ID: <514389AB.7080104@wwwdotorg.org>
References: <1362648969-13737-1-git-send-email-balbi@ti.com> <513904A4.7040101@wwwdotorg.org> <20130308071453.GD21589@arwen.pp.htv.fi> <513A1C63.9050704@wwwdotorg.org> <20130308182623.GD900@arwen.pp.htv.fi> <513A2FDD.2040800@wwwdotorg.org> <20130314110129.GI32369@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130314110129.GI32369-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, Venu Byravarasu <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, cbou-JGs/UdohzUI@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/14/2013 05:01 AM, Felipe Balbi wrote:
> On Fri, Mar 08, 2013 at 11:37:17AM -0700, Stephen Warren wrote:
>> On 03/08/2013 11:26 AM, Felipe Balbi wrote:
>>> On Fri, Mar 08, 2013 at 10:14:11AM -0700, Stephen Warren
>>> wrote:
>>>> On 03/08/2013 12:14 AM, Felipe Balbi wrote:
>>>>> Hi,
>>>>> 
>>>>> On Thu, Mar 07, 2013 at 02:20:36PM -0700, Stephen Warren 
>>>>> wrote:
>>>>>> On 03/07/2013 02:35 AM, Felipe Balbi wrote:
>>>>>>> Hi folks,
>>>>>>> 
>>>>>>> inspired by Paul's DWC2 patchset which added 
>>>>>>> usb_otg_state_string() (a copy of otg_state_string())
>>>>>>> I have now renamed otg_state_string() to 
>>>>>>> usb_otg_state_string(), moved it to usb-common, then
>>>>>>> moved all phy drivers to drivers/usb/phy/ and
>>>>>>> completely deleted the otg directory.
>>>>>>> 
>>>>>>> We're also removing CONFIG_USB_OTG_UTILS since that
>>>>>>> has lots its meaning long ago.
>>>>>>> 
>>>>>>> I have compiled all patches with allyes, allno and
>>>>>>> allmod configs, but please make sure to test on your
>>>>>>> platforms to make sure we're not leaking any more
>>>>>>> problems to mainline.
>>>>>> 
>>>>>> What branch do the patches apply to? They didn't "git am"
>>>>>> for me on either next-20130305, nor 
>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
>>>>>>  next.
>>>>> 
>>>>> they're on top of my testing branch.
>>>> 
>>>> Ah, thanks. I took that whole branch, built ARM's 
>>>> tegra_defconfig, and see:
>>>> 
>>>>> warning: (ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC) selects 
>>>>> USB_ULPI which has unmet direct dependencies (USB_SUPPORT
>>>>> && USB_PHY && ARM) warning: (ARCH_TEGRA_2x_SOC && 
>>>>> ARCH_TEGRA_3x_SOC) selects USB_ULPI_VIEWPORT which has
>>>>> unmet direct dependencies (USB_SUPPORT && USB_PHY &&
>>>>> USB_ULPI) warning: (ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC)
>>>>> selects USB_ULPI which has unmet direct dependencies
>>>>> (USB_SUPPORT && USB_PHY && ARM) warning: (ARCH_TEGRA_2x_SOC
>>>>> && ARCH_TEGRA_3x_SOC) selects USB_ULPI_VIEWPORT which has
>>>>> unmet direct dependencies (USB_SUPPORT && USB_PHY &&
>>>>> USB_ULPI)
>>>> 
>>>> Manually enabling USB_PHY fixes this. However, this
>>>> highlights an issue with your removal of all selects (as
>>>> mentioned in your other email) - it will break perhaps any
>>>> defconfig that has USB enabled.
>>>> 
>>>> After enabling USB_PHY, the code builds and runs without
>>>> issue.
>>> 
>>> fair enough, but then I'm just exposing the trouble. ARCH 
>>> shouldn't select USB_ULTI or any of the phy drivers, for that 
>>> matter.
>> 
>> Yes, I think it should instead work like:
>> 
>> ARCH_TEGRA* selects nothing in particular related to USB.
>> 
>> The Tegra EHCI controller Kconfig depends on ARCH_TEGRA so it
>> doesn't show up for other builds. I hope it's OK for the EHCI
>> controller to select USB_ARCH_HAS_EHCI?
> 
> that's something the ARCH should select but it has very little
> value. I guess there has been some discussions about dropping that
> and I support it.
> 
>> The Tegra EHCI controller Kconfig selects everything needed for
>> it to be useful, i.e. PHY support and the Tegra PHY, and I guess
>> the ULPI viewport options.
> 
> should it ? I don't know... There's no way to select something as 
> module, but there's no eas\(y\|ier\) way to make sure PHY is
> enabled when building EHCI-tegra.
> 
>> The Tegra PHY Kconfig probably shouldn't be user-visible (relying
>> on being selected by the Tegra EHCI controller) and itself
>> selects anything it relies on.
> 
> That I really don't like. I think the driver should be selectable
> and build in anything architecture. That's the easier way to:
> 
> a) build test a driver when applying patches; and b) make sure
> drivers won't include <mach/*> or <asm/*>.

Venu, can you please look into the right changes to make for Tegra,
and drive this forward. Thanks.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
