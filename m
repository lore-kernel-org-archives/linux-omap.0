From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC 2/9] opp-modifier: Add opp-modifier-reg driver
Date: Tue, 18 Mar 2014 10:36:45 -0500
Message-ID: <5328680D.9050103@ti.com>
References: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>	<1394825135-60110-3-git-send-email-d-gerlach@ti.com>	<CAL_Jsq+BzJeaiPwJsH5bFmtsxCPOspEjnmMLdAVyLAriQTF+kw@mail.gmail.com>	<53270710.4060206@ti.com>
 <CAL_JsqLSq+ZhwgOoH7uvh-Otod6iECWTkDMyEvO6MjmdnJ-3Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqLSq+ZhwgOoH7uvh-Otod6iECWTkDMyEvO6MjmdnJ-3Kw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robherring2@gmail.com>
Cc: Jisheng Zhang <jszhang@marvell.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Anson Huang <Anson.Huang@freescale.com>, Dave Gerlach <d-gerlach@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 03/17/2014 01:37 PM, Rob Herring wrote:
> On Mon, Mar 17, 2014 at 9:30 AM, Nishanth Menon <nm@ti.com> wrote:
>> On 03/14/2014 04:00 PM, Rob Herring wrote:
>>> On Fri, Mar 14, 2014 at 2:25 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
>>>> Driver to read from a register and depending on either set bits or
>>>> a specific known selectively enable or disable OPPs based on DT node.
>>>>
>>>> Can support opp-modifier-reg-bit where single bits within the register
>>>> determine the availability of an OPP or opp-modifier-reg-val where a
>>>> certain value inside the register or a portion of it determine what the
>>>> maximum allowed OPP is.
>>>>
>>>> The driver expects a device that has already has its OPPs loaded
>>>> and then will disable the OPPs not matching the criteria specified in
>>>> the opp-modifier table.
>>>>
>>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>>> ---
>>>>  .../devicetree/bindings/power/opp-modifier.txt     | 111 +++++++++
>>>>  drivers/power/opp/Makefile                         |   1 +
>>>>  drivers/power/opp/opp-modifier-reg.c               | 259 +++++++++++++++++++++
>>>>  3 files changed, 371 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/power/opp-modifier.txt
>>>>  create mode 100644 drivers/power/opp/opp-modifier-reg.c
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/power/opp-modifier.txt b/Documentation/devicetree/bindings/power/opp-modifier.txt
>>>> new file mode 100644
>>>> index 0000000..af8a2e9
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/power/opp-modifier.txt
>>>> @@ -0,0 +1,111 @@
>>>> +* OPP-Modifier - opp modifier to selectively enable operating points
>>>> +
>>>> +Many SoCs that have selectively modifiable OPPs can specify
>>>> +all available OPPs in their operating-points listing and then define
>>>> +opp_modifiers to enable or disable the OPPs that are actually available
>>>> +on the specific hardware.
>>>> +
>>>> +* OPP Modifier Provider
>>>
>>> Uggg. Please stop designing around the current OPP binding which has
>>> the problem that the OPP table is not extensible to add more data.
>>> Define a new OPP binding that solves these problems. This is at least
>> Generically, there are three different issues with current OPP bindings:
>> a) ability to enable disable certain OPPs depending on SoC OTP/Efuse
>> settings.
> 
> More generically: ...depending on variety of factors.

Agreed.

> 
>> b) ability to reuse OPPs defined for one device node for another (cpu1
>> to reuse OPP definitions of cpu0)
>> c) ability to add additional information per OPP. we can argue this is
>> a superset of (a), but really, the problems are different.
> 
> It is all additional data per OPP. Additional different information is
> of course for different problems. That doesn't mean we need different
> solutions.
> 
>> Previous proposals include making each OPP as a phandle, but there
>> does not seem much traction in that direction either. - proposal here
>> has nothing to do with (b) or (c).
> 
> They may have nothing to do with each other, but they all have to do
> with the OPP binding. If we're going to change/extend the binding,
> then all issues need to be taken into account.

We aren't extending the existing binding in this series. We are just
defining how hardware description of which OPPs are valid here.

>>> the 3rd OPP related binding addition I've seen recently. But I
>>> wouldn't spend a lot of effort on a new OPP binding just to add the
>>> functionality you are adding here because I don't like the whole
>>> concept in general. This might be a common way to determine valid OPPs
>>> on TI chips, but I think it is too low level and I don't want to see
>>
>> Not just TI chips, but iMX, now, Marvell, Xilinx as well. potentially
>> more as well. doing OTP/Efuse based decision on which OPPs are valid
>> on a chip is not a TI specific thing. This was the reason for us to
>> try to define something generic enough to be reused by more SoCs than
>> just TI.
> 
> Agreed, but I'm not convinced how different SOCs determine valid OPPs
> is common enough. Certainly how to mark an entry disabled is common
> though.

Fair enough, without procuring NDA documents for all the SoCs, I
cannot comment much either, all we can do is see threads such as
http://marc.info/?t=139470791100003&r=1&w=2 and propose.

This series does include iMx as well which seems to have equivalent
challenges.

I have given examples here on how the current driver at least tries to
make generic the instances of SoCs that we have today, further, the
driver in no way constraints us from using opp_modifier_register with
proper ops in case we do something weirdly different (example: use non
memory mapped operations) - it is just a simple framework.

> 
>>> bindings for every different possible way. Just add platform code to
>>> do the OPP setup you need.
>> Errr.. adding platform code means the hardware description goes back
>> to kernel. is'nt that giving up on device tree binding for describing
>> hardware?
> 
> We're always going to have some platform code. I'm not saying you have
> to in this case. I'm saying either come up with an OPP binding
> addressing all these issues or live with the existing one and fix it
> up in the kernel or bootloader.

bootloader is out of the picture considering most of the platforms
need to deal with legacy bootloaders.

then tying part of the data in kernel and part in dts!
> 
>>> Frankly, I prefer the bootloader/firmware fixup the OPP table approach
>>> mentioned in the cpufreq-cpu0 thread. Somewhat less desirable, but the
>>> kernel could do the fixups as well (via of_update_property).
>>
>> a) Trying to move the hardware definition away from device tree seems
>> to me a major step backwards.
>> b) Allowing for definitions in platform code is a step backwards again
>> for a generic solution that works for more than 1 vendor.
>> c) moving the logic away to bootloader when it can easily be done in
>> kernel again is adding burden to bootloader for data it does need to
>> handle.
> 
> The burden has to be somewhere. Maintaining a binding forever in the
> kernel is a burden as well if it is poorly designed.

> 
> Valid OPPs are not going to just be random. There's probably on a few
> combinations and they'll be based on part# or speed grade or something
> (which in turn defines the efuses in your case). While a dev board may
> have random parts on it, an actual product would not. I could argue
> that your DTB just needs to be correct to begin with for a given
> part/design. Obviously, managing minor differences in a DTB like this
> can be a pain. This is why firmware or bootloaders do adjustments to
> the DTB at runtime and it is quite common.
Bootloaders may not always be capable of doing things or may just be
legacy bootloader that were created in a world where kernel was self
sustaining (opp data was in the kernel previously in OMAP as an
example). asking bootloader to change to ensure dtbs are proper is
just opening up another can of worms here.

> 
>> OPP is a hardware behavior, which OPPs are enabled are described in
>> hardware on certain SoCs. the current proposal is to provide a generic
>> solution for those devices that allow for dynamic definition of OPPs
>> based on SoC efuse definition.
> 
> What if the decision is not based on a single register bit? Perhaps
> efuses are not directly memory mapped. Maybe it is based on Si
> revision. Or you need to limit frequency because a certain board can't
> supply adequate current. You call this generic, but it is not. It
> doesn't even solve the part that is generic which is marking some OPPs
> disabled.

Are we saying that having a generic layer which may decide on which
OPPs are valid and which are not is a no-no? the RFC has a few issues,
I agree, but that is part of our review process to help improve if we
think the over all concept is good enough to carry forward for next
patch iteration. You dont seem convinced enough to think that makes
sense here.

As I mentioned, patch #1 is the framework, patch #2 is a specific
implementation(and there are improvements possible)-> if we need to
add sil revision based logic OR have current supply based
implementation OR have non memory mapped based decision making,
there'd be specific drivers for them.

The key question is this: do we have an conceptual agreement that
making the decision on which OPPs are valid is a decision for the
kernel? if yes, lets make that as the standard, if kernel should not
do it, then we enforce discipline that bootloaders will mandatorily
implement dtb modification for OPP entries for all SoCs. If I
understand your thought, I think your push is for dtbs containing the
right OPP entries always.

If we agree that kernel should be standalone capable of handling valid
OPPs (which happens to be my view), then lets debate if a generic
layer such as the one proposed should be created helping all SoCs to
operate generically. So far, none of the arguments you have presented
seems to indicate such a generic layer is impossible to do.

-- 
Regards,
Nishanth Menon
