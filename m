From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] opp: introduce library for device-specific OPPs
Date: Fri, 17 Sep 2010 10:59:06 -0500
Message-ID: <4C93904A.9000109@ti.com>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<AANLkTin2fBriymD7p-YfhPL24hMfYttsZBdighCSJxV2@mail.gmail.com>
	<4C9383C8.4020608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4C9383C8.4020608@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-doc <linux-doc@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Randy Dunlap <rdunlap@xenotime.net>, Pavel Machek <pavel@ucw.cz>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Aguirre,
	Sergio" <saaguirre@ti.com>, Andi Kleen <ak@linux.intel.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Granados
	Dorado, Rober
List-Id: linux-omap@vger.kernel.org

Nishanth Menon had written, on 09/17/2010 10:05 AM, the following:
> Linus Walleij had written, on 09/17/2010 08:41 AM, the following:
>> 2010/9/17 Nishanth Menon <nm@ti.com>:
>>
>>> diff --git a/Documentation/power/00-INDEX b/Documentation/power/00-INDEX
>>> index fb742c2..45e9d4a 100644
>>> --- a/Documentation/power/00-INDEX
>>> +++ b/Documentation/power/00-INDEX
>>> @@ -14,6 +14,8 @@ interface.txt
>>>        - Power management user interface in /sys/power
>>>  notifiers.txt
>>>        - Registering suspend notifiers in device drivers
>>> +opp.txt
>>> +       - Operating Performance Point library
>>>  pci.txt
>>>        - How the PCI Subsystem Does Power Management
>> Hm you add the documentation to the index but not the documentation
>> itself (easy slip) would you mind posting it?
> ouch.. Sorry.. I realized that I missed adding MAINTAINER entry as 
> well.. v2 coming up..
> 

while the review goes on, I will till end of the day before posting a v2 
will collated comments, here is the opp.txt documentation for the same.. 
apologies on missing in my v1..

OPP Layer
==============
SOCs have a standard set of tuples consisting of frequency and
voltage pairs that the device will support per voltage domain. This
is called Operating Performance Point or OPP. The actual definitions
of OPP varies over silicon within the same family of devices.
For a specific domain, you can have a set of {frequency, voltage}
pairs. As the kernel boots and more information is available, a set
of these are activated based on the precise nature of device the kernel
boots up on. It is interesting to remember that each IP which belongs
to a voltage domain may define their own set of OPPs on top of this.

OPP layer of its own depends on silicon specific implementation and
board specific data to finalize on the final set of OPPs available
in a system

OPP layer organizes the data internally using device pointers representing
individual voltage domains.

NOTE:
a) the OPP layer implementation expects to be used in multiple contexts
based on SOC implementation and recommends locking schemes appropriate to
the usage of SOC.
b) All pointer returns are expected to be handled by standard error checks
such as IS_ERR() and appropriate actions taken by the caller.
c) Dependency of OPP layer is on CONFIG_PM as certain SOCs such as Texas
Instrument's OMAP support have frameworks to optionally boot at a certain
opp without needing cpufreq.

Initial list initialization:
---------------------------
The SOC implementation calls the following function to add opp per
domain device.

1. opp_add - add a new OPP - NOTE: use struct opp_def and define
the custom OPP with OPP_DEF for usage.

Query functions:
----------------
Search for OPPs for various cases:
2. opp_find_freq_exact - exact search function
3. opp_find_freq_floor - round_up search function
4. opp_find_freq_ceil - round_down search function

OPP modifier functions:
----------------------
This allows opp layer users to add customized OPPs or change the table
for any need they may have
5. opp_enable - enable a disabled OPP
6. opp_disable - disable an enabled OPP

OPP Data retrieval functions:
----------------------------
The following sets of functions are useful for drivers to retrieve
data stored in opp layer for various functions.
7. opp_get_voltage - retrieve voltage for an opp
9. opp_get_freq - get the frequency for an opp
8. opp_get_opp_count - get number of opps enabled for a domain

Cpufreq table generation:
------------------------
9. opp_init_cpufreq_table - this translates the OPP layer's internal
OPP arrangement into a table understood and operated upon by the
cpufreq layer.

Data Structures:
---------------
struct opp * is a handle structure whose internals are known only
to the OPP layer and is meant to hide the complexity away from users of
opp layer.

struct opp_def * is the definitions that users can interface with
opp layer and is meant to define one OPP for a domain device.


-- 
Regards,
Nishanth Menon
