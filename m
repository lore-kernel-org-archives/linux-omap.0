From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP PM interface, version 2
Date: Tue, 17 Jun 2008 09:01:22 -0600
Message-ID: <20080617145905.20886.89236.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55211 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755713AbYFQPFO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2008 11:05:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, jouni.hogander@nokia.com, khilman@mvista.com

Hello everyone,

this is the second version of the OMAP PM interface patch.

Major changes since the first version:

1. Jouni Hogander suggested that the set_max_cpu_lat() function be
   merged into set_max_dev_wakeup_lat(), when set_max_dev_wakeup_lat()
   is called with the CPU0 sys_device (via get_cpu_sysdev(0)).  He feel=
s
   that this will be easier for device driver developers to use.  This
   change has been made.

2. set_max_bus_lat() now takes an "agent_id" parameter instead of a=20
   "struct bus *bus".  agent_id will be either OCP_TARGET_AGENT or
   OCP_INITIATOR_AGENT.

3. Initialization is now split into an early init section, called befor=
e
   the clock framework initializes; and a later init section, called
   after clock framework init.  Init functions also renamed to avoid
   clashing with existing function names.

4. Several documentation bugs fixed.


Thanks also to Kevin Hilman <khilman@mvista.com> for his comments.

=46urther comments welcome,


- Paul=20

---------------------------------

This message proposes the second version of a power management
interface (the "OMAP PM interface") for the linux-omap kernel tree.

It includes a general device driver PM interface, along with some
specialized interfaces for CPUFreq, DSPBridge, and the
powerdomain/clockdomain code.  This message focuses on the general
device driver portion, since it is most relevant to the larger
community of OMAP device driver developers.

The interface is intended to allow drivers to take advantage of OMAP
power management features:

- without locking drivers into a particular underlying implementation;

- without adding constraints that are specific to particular OMAP
  variants; and

- without affecting other architectures.

The device driver portion of the interface covers three types of PM
constraints:

1. Set the minimum bus throughput needed by a device;

2. Set the maximum device wakeup latency (also includes MPU).

3. Set the maximum DMA transfer start latency (CORE pwrdm);

These are described in more detail below.

This interface is intended to be temporary, to survive only until the
Linux PM QoS layer supports these features.

This interface is a collaborative product of many people from Nokia
and TI: Karthik Dasu, Jouni H=C3=B6gander, Tony Lindgren, Rajendra Naya=
k,
Sakari Poussa, Veeramanikandan Raju, Anand Sawant, Igor Stoppa, Paul
Walmsley, and Richard Woodruff.

Included in the patch is a 'no-op' implementation that documents the
interface and emits debug messages.  Rajendra Nayak at TI has
developed an initial implementation of the OMAP PM interface that
relies mostly on TI's Shared Resource Framework.  Also under
development is an implementation of the OMAP PM code that uses the
existing Linux PM QoS code.


Comments welcomed,

- Paul



Rationale: the OMAP PM interface
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D


Existing PM interfaces are currently not ideal for OMAP
-------------------------------------------------------

There are two PM interfaces in use with publicly-distributed OMAP
Linux code: the TI Shared Resource Framework (SRF) and the Linux PM
QoS parameters code.  Neither interface is ideal for Linux OMAP code.

TI Shared Resource Framework:

The TI CDP 12.14 tree drivers currently use the TI Shared Resource
=46ramework (SRF) to control chip power management.  Use of the SRF
allowed TI to get the drivers up and running quickly with considerable
power savings; and the SRF provided debugging support.  However, many
of the SRF parameters are specified in OMAP-specific terms, such as
target OPPs, rather than in terms of actual latency or throughput
requirements.  OPPs change depending on OMAP silicon revisions or OMAP
types, and are meaningless for other architectures, so drivers shared
between OMAP and other architectures would also have to #ifdef out the
SRF constraints.

Linux PM QoS parameters:

In February, the mainline Linux kernel added code that is somewhat
similar to the SRF: the Linux PM QoS parameters code, located in
kernel/pm_qos_params.c.  (This code replaced the latency management
code that was present in earlier kernels.)  Ideally, OMAP drivers
would be able to use this Linux PM QoS code directly, but the PM QoS
code has some drawbacks:

- It combines some power management parameters that should be kept
  separate for maximum power savings on OMAP3.  For example, in the PM
  QoS code, CPU and DMA wakeup latency are combined into one
  parameter; but on OMAP3, these are distinct parameters.  The Linux
  PM QoS code also combines all network power management knobs into
  two non-device-specific parameters.  OMAP2/3 systems can have
  different network devices with different power management
  requirements - for example, a wired Ethernet interface may have
  different latency and throughput constraints than a WiFi interface.

- It does not yet cover all of the power management capabilities of
  the OMAP3 architecture.  It does not express latency constraints on
  a per-device or per-powerdomain basis; it only covers
  cpu_dma_latency and network throughput and latency, which would not
  cover most of the OMAP3 devices.

The result is that drivers using the current Linux PM QoS layer
directly are unlikely to reach the same level of power efficiency as
driver code using the Shared Resource Framework.

To summarize, the SRF provides significant power savings, but
expresses power constraints in an OMAP- and silicon-revision-specific
way; and the PM QoS layer expresses PM constraints in a cross-platform
manner (in terms of fundamental physical units), but does not support
per-powerdomain constraints and does not cover many of the OMAP power
management features.


A medium-term alternative: the OMAP PM interface
------------------------------------------------

We need a way for driver code to express PM parameters which:

- supports the range of power management parameters present in the TI S=
RF;

- separates the drivers from the underlying PM parameter
  implementation, whether it is the TI SRF or Linux PM QoS or Linux
  latency framework or something else;

- specifies PM parameters in terms of fundamental units, such as
  latency and throughput, rather than units which are specific to OMAP
  or to particular OMAP variants;

- allows drivers which are shared with other architectures (e.g.,
  DaVinci) to add these constraints in a way which won't affect non-OMA=
P
  systems,

- can be implemented immediately with minimal disruption of other
  architectures.


We therefore propose the OMAP PM interface, including the following
four power management functions for driver code:

1. Set the minimum bus throughput needed by a device:
   (*pdata->set_min_bus_tput)(struct device *dev, u8 agent_id, unsigned=
 long r)

2. Set the maximum device wakeup latency:
   (*pdata->set_max_dev_wakeup_lat)(struct device *dev, unsigned long t=
)

3. Set the maximum DMA transfer start latency (CORE pwrdm):
   (*pdata->set_max_dma_lat)(struct device *dev, long t)


These functions are extensively documented in the no-op OMAP PM layer
patch.


The OMAP PM layer is intended to be temporary
---------------------------------------------

The intention is that, in time, the Linux PM QoS layer should support
the range of power management features present in OMAP3.  As this
happens, existing drivers using the OMAP PM interface can be modified
to use the Linux PM QoS code; and the OMAP PM interface can disappear.


Driver usage of the OMAP PM functions
-------------------------------------

As the 'pdata' in the above examples indicates, these functions are
exposed to drivers through function pointers in driver .platform_data
structures.  The function pointers are initialized by the board-*.c
files to point to the corresponding OMAP PM functions:
=2Eset_max_dev_wakeup_lat will point to
omap_pm_set_max_dev_wakeup_lat(), etc.  Other architectures which do
not support these functions should leave these function pointers set
to NULL.  Drivers should use the following idiom:

        if (pdata->set_max_dev_wakeup_lat)
            (*pdata->set_max_dev_wakeup_lat)(dev, t);


The most common usage of these functions will probably be to specify
the maximum time from when an interrupt occurs, to when the device
becomes accessible.  To accomplish this, driver writers should use the
set_max_dev_wakeup_lat() function twice: once to constrain the MPU
wakeup latency, and once to constrain the device wakeup latency (from
clk_enable() to accessibility).  For example,

        if (pdata->set_max_dev_wakeup_lat) {
            struct sys_device *cpu0_dev;

            /* Limit MPU wakeup latency */
            cpu0_dev =3D get_cpu_sysdev(0);=20
            (*pdata->set_max_dev_wakeup_lat)(cpu0_dev, tc);

            /* Limit device powerdomain wakeup latency */
            (*pdata->set_max_dev_wakeup_lat)(dev, td);
        }
        /* total wakeup latency in this example: (tc + td) */

The PM parameters can be overwritten by calling the function again
with the new value.  The settings can be removed by calling the
function with a t argument of -1 (except in the case of
set_max_bus_tput(), which should be called with an r argument of 0).


Other specialized interface functions
-------------------------------------

The three functions listed above are intended to be usable by any
device driver.  However, DSPBridge and CPUFreq have special
requirements.  DSPBridge expresses target DSP performance levels in
terms of OPP IDs.  CPUFreq expresses target MPU performance levels in
terms of MPU frequency.  The OMAP PM interface contains functions for
these specialized cases to convert that input information (OPPs/MPU
frequency) into the form that the underlying power management
implementation needs:

4. (*pdata->omap_pm_dsp_set_min_opp)(u8 opp_id)

5. (*pdata->omap_pm_dsp_get_opp)(void)

6. (*pdata->omap_pm_cpu_get_freq_table)(void)

7. (*pdata->omap_pm_cpu_set_freq)(unsigned long f)

8. (*pdata->omap_pm_cpu_get_freq)(void)


There are also functions for use by the clockdomain layer to indicate
that a powerdomain should wake up or be put to sleep:

9. (*pdata->omap_pm_pwrdm_active)(struct powerdomain *pwrdm)

10. (*pdata->omap_pm_pwrdm_inactive)(struct powerdomain *pwrdm)


These functions are documented in the patch.

---

Paul Walmsley (1):
      OMAP2/3 PM: Add OMAP PM no-op layer


 arch/arm/mach-omap2/io.c            |    4=20
 arch/arm/plat-omap/Kconfig          |   13 +
 arch/arm/plat-omap/Makefile         |    1=20
 arch/arm/plat-omap/omap-pm-noop.c   |  409 +++++++++++++++++++++++++++=
++++++++
 include/asm-arm/arch-omap/omap-pm.h |   54 +++++
 5 files changed, 481 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/omap-pm-noop.c
 create mode 100644 include/asm-arm/arch-omap/omap-pm.h



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
