From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] opp: introduce library for device-specific
	OPPs
Date: Fri, 17 Sep 2010 18:19:48 -0500
Message-ID: <4C93F794.1030308@ti.com>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<4C9383C8.4020608@ti.com> <4C93904A.9000109@ti.com>
	<201009180045.56122.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009180045.56122.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>, Andi@smtp1.linux-foundation.org, linux-doc <linux-doc@vger.kernel.org>, "Chikkature Rajashekar,
	Madhusudhan" <madhu.cr@ti.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "H. Peter Anvin" <hpa@zytor.com>, "Aguirre,
	Sergio" <saaguirre@ti.com>, Kleen <ak@linux.intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "Granados
	Dorado, Roberto" <x0095451@ti.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Linus Walleij <linus.ml.walleij@gmail.com>, lkml <linux-kernel@vg>
List-Id: linux-omap@vger.kernel.org

Rafael J. Wysocki had written, on 09/17/2010 05:45 PM, the following:

Thanks for your review. few views below..

> On Friday, September 17, 2010, Nishanth Menon wrote:
>> Nishanth Menon had written, on 09/17/2010 10:05 AM, the following:
>>> Linus Walleij had written, on 09/17/2010 08:41 AM, the following:
>>>> 2010/9/17 Nishanth Menon <nm@ti.com>:
>>>>
>>>>> diff --git a/Documentation/power/00-INDEX b/Documentation/power/00-INDEX
>>>>> index fb742c2..45e9d4a 100644
>>>>> --- a/Documentation/power/00-INDEX
>>>>> +++ b/Documentation/power/00-INDEX
>>>>> @@ -14,6 +14,8 @@ interface.txt
>>>>>        - Power management user interface in /sys/power
>>>>>  notifiers.txt
>>>>>        - Registering suspend notifiers in device drivers
>>>>> +opp.txt
>>>>> +       - Operating Performance Point library
>>>>>  pci.txt
>>>>>        - How the PCI Subsystem Does Power Management
>>>> Hm you add the documentation to the index but not the documentation
>>>> itself (easy slip) would you mind posting it?
>>> ouch.. Sorry.. I realized that I missed adding MAINTAINER entry as 
>>> well.. v2 coming up..
>>>
>> while the review goes on, I will till end of the day before posting a v2 
>> will collated comments, here is the opp.txt documentation for the same.. 
>> apologies on missing in my v1..
> 
> OK, I'm not generally familiar with these things, so a couple of questions.
> 
>> OPP Layer
>> ==============
>> SOCs have a standard set of tuples consisting of frequency and
>> voltage pairs that the device will support per voltage domain. This
>> is called Operating Performance Point or OPP. The actual definitions
>> of OPP varies over silicon within the same family of devices.
>> For a specific domain, you can have a set of {frequency, voltage}
>> pairs. As the kernel boots and more information is available, a set
>> of these are activated based on the precise nature of device the kernel
>> boots up on.
> 
> Does it mean that the full set of possible OPPs is already known from the
> hardware configuration and the ones that are actually useable are found
> during boot?

yes. example - https://patchwork.kernel.org/patch/183742/ (based on 
original patch posted to l-arm, this will need some tweaks with the 
latest evolution, the concepts remain the same).

For example, consider in the patch above where we have a opp definitions 
we can choose from omap3430 and 3630,

when using 3630 silicon as a specific, certain boards wish to enable 
1GHz, this allows us to do something as follows:
in the generic omap code, we do init of all opps
in the board specific file, we enable 1Ghz

The selection of oppset and actual availability is done on the fly.

> 
>> It is interesting to remember that each IP which belongs
>> to a voltage domain may define their own set of OPPs on top of this.
> 
> What does IP stand for in this context?
I had intended domains linked to an IP Block within an SOC - in the case 
of OMAP as an example we may have scenarios where voltage levels are 
optimized beyond those defined in the original OPP tables using a TI 
hardware IP called SmartReflex AVS (ok many SOCs probably are not that 
complex.. but it is a cool feature to enable improve the power 
consumption). more: 
http://www.powersystemsdesign.com/index.php?option=com_content&view=article&id=168&Itemid=107

So in reality once you enable you'd have a lot more tuples of (Fx, 
Vnom),(Fx, Vopt1), (Fx, Vopt2).... where (Fx, Vnom) is the original opp 
definition.

Unfortunately our framework for supporting this is still in churn and 
probably not ready for upstream yet.

> 
>> OPP layer of its own depends on silicon specific implementation and
>> board specific data to finalize on the final set of OPPs available
>> in a system
> 
> How does the kernel learn about these things?  Do they need to be hardcoded
> or is there any dynamic configuration mechanism available?

yes, it is prefered to allow this to be SOC specific - every SOC 
(including various OMAP families) have their capabilities allowing them 
to implement the detection and configuration differently.. maybe device 
trees could be in use in one SOCx, but SOCy might choose to implement a 
run time detection as demonstrated in the link above.

> 
>> OPP layer organizes the data internally using device pointers representing
>> individual voltage domains.
> 
> Can you please describe these data structures in a bit more detail?
probably a dumb question: Is'nt it enough to give detailed verbose 
information in the  struct comment header? why duplicate here as well.. 
other than giving an overview?

> 
>> NOTE:
>> a) the OPP layer implementation expects to be used in multiple contexts
>> based on SOC implementation and recommends locking schemes appropriate to
>> the usage of SOC.
>> b) All pointer returns are expected to be handled by standard error checks
>> such as IS_ERR() and appropriate actions taken by the caller.
> 
> I noticed that in a few places it isn't really necessary to return a pointer.
> I think you can simply return int in such cases.
could you help and point these to me. opp_find_freq_exact, 
opp_find_freq_ceil, opp_find_freq_floor are the only ones that return 
pointers and they need to return the pointer to the opp they found to 
operate on them such as add_freq etc..

> 
>> c) Dependency of OPP layer is on CONFIG_PM as certain SOCs such as Texas
>> Instrument's OMAP support have frameworks to optionally boot at a certain
>> opp without needing cpufreq.
>>
>> Initial list initialization:
>> ---------------------------
>> The SOC implementation calls the following function to add opp per
>> domain device.
>>
>> 1. opp_add - add a new OPP - NOTE: use struct opp_def and define
>> the custom OPP with OPP_DEF for usage.
>>
>> Query functions:
>> ----------------
>> Search for OPPs for various cases:
>> 2. opp_find_freq_exact - exact search function
>> 3. opp_find_freq_floor - round_up search function
>> 4. opp_find_freq_ceil - round_down search function
> 
> What do they do exactly?
I assume you are expecting to get a little more verbose data here to the 
effect:
2. opp_find_freq_exact - function to find an opp with exact match to a 
provided frequency
3. opp_find_freq_floor - function to find an opp with rounded floor 
match to a provided frequency
4. opp_find_freq_ceil - function to find an opp with rounded ceil match 
to a provided frequency
> 
>> OPP modifier functions:
>> ----------------------
>> This allows opp layer users to add customized OPPs or change the table
> 
> How exactly is that supposed to work?
:) This is more from the real way folks who use the OPP on thier 
platforms face. As an example: OMAP3630 supports 100MHz and 200MHz for 
the L3 bus driving DDR. some platforms choose not to have 200MHz DDR due 
to some internal reasons, instead they choose a DDR - for the sake of 
argument say 166MHz. This is not actually "official OPP" from TI 
perspective, but these platforms need to do:
init_omap_default_opps()
add_my_custom_166MHz_opp()
disable_the_default_200MHz()

Disclaimer to prevent OMAP guys from flaming me: the values used in my 
example are hypothetical and is not an official statement from TI to use 
166MHz on OMAP3630 ;). But there are folks not using 200MHz and they 
know the pain if this runtime addition was not possible.

> 
>> for any need they may have
>> 5. opp_enable - enable a disabled OPP
>> 6. opp_disable - disable an enabled OPP
>>
>> OPP Data retrieval functions:
>> ----------------------------
>> The following sets of functions are useful for drivers to retrieve
>> data stored in opp layer for various functions.
>> 7. opp_get_voltage - retrieve voltage for an opp
>> 9. opp_get_freq - get the frequency for an opp
>> 8. opp_get_opp_count - get number of opps enabled for a domain
> 
> OK, suppose I'm writing a driver that needs to care.  What should I use these
> functions for?
opp_get_opp_count gets the number of opps available for that domain - 
you may choose to setup some sort of array containing some special data 
on it.
cpufreq SOCs impleemntation might be told to go to a frequency, it makes 
sense for the implementation to pick up the opp pointer  with search 
function and call opp_get_voltage to get the voltage to scale voltage etc..

Or am I missing your intent here? I did not intend to explain the 
concept of power management in this documentation..

> 
>> Cpufreq table generation:
>> ------------------------
>> 9. opp_init_cpufreq_table - this translates the OPP layer's internal
>> OPP arrangement into a table understood and operated upon by the
>> cpufreq layer.
>>
>> Data Structures:
>> ---------------
>> struct opp * is a handle structure whose internals are known only
>> to the OPP layer and is meant to hide the complexity away from users of
>> opp layer.
>>
>> struct opp_def * is the definitions that users can interface with
>> opp layer and is meant to define one OPP for a domain device.
> 
> The data structures require some more description IMHO.  They aren't completely
> intuitive.

ok, a repeat question -> why duplicate the information defined in the 
structure comment header?


-- 
Regards,
Nishanth Menon
