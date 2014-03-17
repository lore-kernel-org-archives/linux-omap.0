From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC 2/9] opp-modifier: Add opp-modifier-reg driver
Date: Mon, 17 Mar 2014 09:30:40 -0500
Message-ID: <53270710.4060206@ti.com>
References: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>	<1394825135-60110-3-git-send-email-d-gerlach@ti.com>
 <CAL_Jsq+BzJeaiPwJsH5bFmtsxCPOspEjnmMLdAVyLAriQTF+kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_Jsq+BzJeaiPwJsH5bFmtsxCPOspEjnmMLdAVyLAriQTF+kw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robherring2@gmail.com>, Dave Gerlach <d-gerlach@ti.com>
Cc: Jisheng Zhang <jszhang@marvell.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Anson Huang <Anson.Huang@freescale.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 03/14/2014 04:00 PM, Rob Herring wrote:
> On Fri, Mar 14, 2014 at 2:25 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
>> Driver to read from a register and depending on either set bits or
>> a specific known selectively enable or disable OPPs based on DT node.
>>
>> Can support opp-modifier-reg-bit where single bits within the register
>> determine the availability of an OPP or opp-modifier-reg-val where a
>> certain value inside the register or a portion of it determine what the
>> maximum allowed OPP is.
>>
>> The driver expects a device that has already has its OPPs loaded
>> and then will disable the OPPs not matching the criteria specified in
>> the opp-modifier table.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>>  .../devicetree/bindings/power/opp-modifier.txt     | 111 +++++++++
>>  drivers/power/opp/Makefile                         |   1 +
>>  drivers/power/opp/opp-modifier-reg.c               | 259 +++++++++++++++++++++
>>  3 files changed, 371 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/opp-modifier.txt
>>  create mode 100644 drivers/power/opp/opp-modifier-reg.c
>>
>> diff --git a/Documentation/devicetree/bindings/power/opp-modifier.txt b/Documentation/devicetree/bindings/power/opp-modifier.txt
>> new file mode 100644
>> index 0000000..af8a2e9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/opp-modifier.txt
>> @@ -0,0 +1,111 @@
>> +* OPP-Modifier - opp modifier to selectively enable operating points
>> +
>> +Many SoCs that have selectively modifiable OPPs can specify
>> +all available OPPs in their operating-points listing and then define
>> +opp_modifiers to enable or disable the OPPs that are actually available
>> +on the specific hardware.
>> +
>> +* OPP Modifier Provider
> 
> Uggg. Please stop designing around the current OPP binding which has
> the problem that the OPP table is not extensible to add more data.
> Define a new OPP binding that solves these problems. This is at least
Generically, there are three different issues with current OPP bindings:
a) ability to enable disable certain OPPs depending on SoC OTP/Efuse
settings.
b) ability to reuse OPPs defined for one device node for another (cpu1
to reuse OPP definitions of cpu0)
c) ability to add additional information per OPP. we can argue this is
a superset of (a), but really, the problems are different.

Previous proposals include making each OPP as a phandle, but there
does not seem much traction in that direction either. - proposal here
has nothing to do with (b) or (c).

> the 3rd OPP related binding addition I've seen recently. But I
> wouldn't spend a lot of effort on a new OPP binding just to add the
> functionality you are adding here because I don't like the whole
> concept in general. This might be a common way to determine valid OPPs
> on TI chips, but I think it is too low level and I don't want to see

Not just TI chips, but iMX, now, Marvell, Xilinx as well. potentially
more as well. doing OTP/Efuse based decision on which OPPs are valid
on a chip is not a TI specific thing. This was the reason for us to
try to define something generic enough to be reused by more SoCs than
just TI.

> bindings for every different possible way. Just add platform code to
> do the OPP setup you need.
Errr.. adding platform code means the hardware description goes back
to kernel. is'nt that giving up on device tree binding for describing
hardware?

> 
> Frankly, I prefer the bootloader/firmware fixup the OPP table approach
> mentioned in the cpufreq-cpu0 thread. Somewhat less desirable, but the
> kernel could do the fixups as well (via of_update_property).

a) Trying to move the hardware definition away from device tree seems
to me a major step backwards.
b) Allowing for definitions in platform code is a step backwards again
for a generic solution that works for more than 1 vendor.
c) moving the logic away to bootloader when it can easily be done in
kernel again is adding burden to bootloader for data it does need to
handle.

OPP is a hardware behavior, which OPPs are enabled are described in
hardware on certain SoCs. the current proposal is to provide a generic
solution for those devices that allow for dynamic definition of OPPs
based on SoC efuse definition.


-- 
Regards,
Nishanth Menon
