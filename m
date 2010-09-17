From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] opp: introduce library for device-specific
	OPPs
Date: Sat, 18 Sep 2010 00:45:55 +0200
Message-ID: <201009180045.56122.rjw@sisk.pl>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<4C9383C8.4020608@ti.com> <4C93904A.9000109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C93904A.9000109@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nishanth Menon <nm@ti.com>
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>, linux-doc <linux-doc@vger.kernel.org>, "Chikkature Rajashekar,
	Madhusudhan" <madhu.cr@ti.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "H. Peter Anvin" <hpa@zytor.com>, "Aguirre,
	Sergio" <saaguirre@ti.com>, Andi Kleen <ak@linux.intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, "Granados Dorado, Roberto" <x0095451@ti.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Linus Walleij <linus.ml.walleij@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Romit
List-Id: linux-omap@vger.kernel.org

On Friday, September 17, 2010, Nishanth Menon wrote:
> Nishanth Menon had written, on 09/17/2010 10:05 AM, the following:
> > Linus Walleij had written, on 09/17/2010 08:41 AM, the following:
> >> 2010/9/17 Nishanth Menon <nm@ti.com>:
> >>
> >>> diff --git a/Documentation/power/00-INDEX b/Documentation/power/00-INDEX
> >>> index fb742c2..45e9d4a 100644
> >>> --- a/Documentation/power/00-INDEX
> >>> +++ b/Documentation/power/00-INDEX
> >>> @@ -14,6 +14,8 @@ interface.txt
> >>>        - Power management user interface in /sys/power
> >>>  notifiers.txt
> >>>        - Registering suspend notifiers in device drivers
> >>> +opp.txt
> >>> +       - Operating Performance Point library
> >>>  pci.txt
> >>>        - How the PCI Subsystem Does Power Management
> >> Hm you add the documentation to the index but not the documentation
> >> itself (easy slip) would you mind posting it?
> > ouch.. Sorry.. I realized that I missed adding MAINTAINER entry as 
> > well.. v2 coming up..
> > 
> 
> while the review goes on, I will till end of the day before posting a v2 
> will collated comments, here is the opp.txt documentation for the same.. 
> apologies on missing in my v1..

OK, I'm not generally familiar with these things, so a couple of questions.

> OPP Layer
> ==============
> SOCs have a standard set of tuples consisting of frequency and
> voltage pairs that the device will support per voltage domain. This
> is called Operating Performance Point or OPP. The actual definitions
> of OPP varies over silicon within the same family of devices.
> For a specific domain, you can have a set of {frequency, voltage}
> pairs. As the kernel boots and more information is available, a set
> of these are activated based on the precise nature of device the kernel
> boots up on.

Does it mean that the full set of possible OPPs is already known from the
hardware configuration and the ones that are actually useable are found
during boot?

> It is interesting to remember that each IP which belongs
> to a voltage domain may define their own set of OPPs on top of this.

What does IP stand for in this context?

> OPP layer of its own depends on silicon specific implementation and
> board specific data to finalize on the final set of OPPs available
> in a system

How does the kernel learn about these things?  Do they need to be hardcoded
or is there any dynamic configuration mechanism available?

> OPP layer organizes the data internally using device pointers representing
> individual voltage domains.

Can you please describe these data structures in a bit more detail?

> NOTE:
> a) the OPP layer implementation expects to be used in multiple contexts
> based on SOC implementation and recommends locking schemes appropriate to
> the usage of SOC.
> b) All pointer returns are expected to be handled by standard error checks
> such as IS_ERR() and appropriate actions taken by the caller.

I noticed that in a few places it isn't really necessary to return a pointer.
I think you can simply return int in such cases.

> c) Dependency of OPP layer is on CONFIG_PM as certain SOCs such as Texas
> Instrument's OMAP support have frameworks to optionally boot at a certain
> opp without needing cpufreq.
> 
> Initial list initialization:
> ---------------------------
> The SOC implementation calls the following function to add opp per
> domain device.
> 
> 1. opp_add - add a new OPP - NOTE: use struct opp_def and define
> the custom OPP with OPP_DEF for usage.
> 
> Query functions:
> ----------------
> Search for OPPs for various cases:
> 2. opp_find_freq_exact - exact search function
> 3. opp_find_freq_floor - round_up search function
> 4. opp_find_freq_ceil - round_down search function

What do they do exactly?

> OPP modifier functions:
> ----------------------
> This allows opp layer users to add customized OPPs or change the table

How exactly is that supposed to work?

> for any need they may have
> 5. opp_enable - enable a disabled OPP
> 6. opp_disable - disable an enabled OPP
> 
> OPP Data retrieval functions:
> ----------------------------
> The following sets of functions are useful for drivers to retrieve
> data stored in opp layer for various functions.
> 7. opp_get_voltage - retrieve voltage for an opp
> 9. opp_get_freq - get the frequency for an opp
> 8. opp_get_opp_count - get number of opps enabled for a domain

OK, suppose I'm writing a driver that needs to care.  What should I use these
functions for?

> Cpufreq table generation:
> ------------------------
> 9. opp_init_cpufreq_table - this translates the OPP layer's internal
> OPP arrangement into a table understood and operated upon by the
> cpufreq layer.
> 
> Data Structures:
> ---------------
> struct opp * is a handle structure whose internals are known only
> to the OPP layer and is meant to hide the complexity away from users of
> opp layer.
> 
> struct opp_def * is the definitions that users can interface with
> opp layer and is meant to define one OPP for a domain device.

The data structures require some more description IMHO.  They aren't completely
intuitive.

Thanks,
Rafael
