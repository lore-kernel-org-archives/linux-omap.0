From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH v6 0/7] ARM: OMAP2+: PM: introduce the power domains functional states
Date: Wed, 12 Sep 2012 11:55:25 +0200
Message-ID: <1347443732-7411-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33587 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab2ILJzu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 05:55:50 -0400
Received: by wibhi8 with SMTP id hi8so5017290wib.1
        for <linux-omap@vger.kernel.org>; Wed, 12 Sep 2012 02:55:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>, Rajendra Nayak <rnayak@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>

Here is a re-spin after some comments and suggestions after review
and discussions.

Implement the functional states for the power domains:
- unify the API to use the functional states. The new API
  consists of the pwrdm_set*_fpwrst and pwrdm_read*_fpwrst
  functions and is the API to use to control the power domains
  power and logic states,
- reorganize the powerdomain API in internal and external parts,
  in powerdomain.h [1]
- protect the power domain state change by a lock in the
  functions that read and set the powerdomains next functional state,
- introduce the functional states for power domains power states and
  logic power states [2], and the conversion functions between the
  functional and internal states. The conversion functions are
  lightweight and generic. The power domains allowed states [3] are
  defined in the pwrsts and pwrsts_logic_ret fields of the struct
  powerdomain,
- program the logic power state of power domains from the functional
  states, in pwrdm_set*_fpwrst
- convert the OMAP2/3/4 PM code to use the updated API,
- provide the power domains statistics by functional states,
- provide ftrace tracepoints with the functional state,
- provide error logs in critical code, which makes the development
  easier.

Notes:
[1] the physical split of internal and external APIs into
   different header files is not part of this series, it comes as
   a separate patch set.
[2] the abstraction for functional power states provides a generic
   way of controlling the power domains states across all OMAP
   chipsets and revisions. The users of the functional power states
   are (1) the OMAP PM components: cpuidle, suspend, pmxxxx, clock*
   and (2) the per-device PM QoS constraints and the generic power
   domain frameworks. All those users require a generic abstraction
   of the power domain states while the low level power domain code
   has the knowledge of the internal settings (power, logic... states).
[3] About the power domains allowed states:
   Power domains have varied capabilities, as defined by the value of
   the pwrsts and pwrsts_logic_ret fields of the powerdomain struct.
   When reading or setting a low power state such as OFF/RET, a specific
   requested state may not be supported on the given power domain.
   In the states conversion functions a power or logic state is first
   looked for in the lower power states in order to maximize the power
   savings, then if not found in the higher power states. An iteration
   function is used, as suggested by Rajendra Nayak <rnayak@ti.com>
   This functionality brings consistency in the functional power states
   core code and acts as a guard against hardware implementations
   discrepancies, e.g. some power domains only support the RET logic
   state although reading the logic state registers (previous, current
   and next) always returns OFF. The DSS power domain on OMAP3 is an
   example.


Based on mainline kernel 3.6.0-rc4.

Tested on OMAP3 Beagleboard, with suspend and cpuidle in RET and
OFF modes.


History:
 v6:
 - rework to a lighter and generic conversion mechanism between the
   functional and the internal states (static internal functions
   are defined instead of using the pwrdm fops function pointers),
 - the functional power states API now has a function to set the next
   power state (pwrdm_set_next_fpwrst) and a function to program (i.e.
   set, apply the state and wait for completion) the power state
   (pwrdm_set_fpwrst),
 - When attempting a low power state such as OFF/RET, a specific
   requested state may not be supported on the given power domain.
   In the states conversion functions a power state is first looked
   for in the lower power states in order to maximize the power savings,
   then if not found in the higher power states. Only allowed states are
   returned by the conversion functions, as defined by the value of the
   pwrsts and pwrsts_logic_ret fields of the powerdomain struct.
 - added more error logging: check for NULL in pwrdm, better error
   messages using pr_err_ratelimited etc.

 v5:
 - complete rework after review and suggestions,
 - improved locking on next state read/write; spinlock instead of mutex
 - added more error logging in critical code,

 v4:
 - reworked the code after internal review and testing with OMAP3&4 device
   OFF,
 - fixed the tracepoints generation code,
 - introduce a function that returns power domains achievable functional
   states, in order to return a valid state for power domains that only
   support some of the power states. Although it has been tested OK the
   code is in RFC state.

 v3:
 - fix a bug in OMAP3 cpuidle which prevented the IO wake-ups in PER

 v2:
 - add the logic power states,
 - provide the power domains statistics by functional states

 v1:
 - initial implementation, in RFC state


Jean Pihet (6):
  ARM: OMAP2+: PM: introduce power domains functional states
  ARM: OMAP2+: PM: add a lock to protect the powerdomains next state
  ARM: OMAP2+: PM: use the functional power states API
  ARM: OMAP2+: PM: use power domain functional state in stats counters
  ARM: OMAP2+: PM debug: trace the functional power domains states
  ARM: OMAP2+: PM: reorganize the powerdomain API in public and private
    parts

Nishanth Menon (1):
  ARM: OMAP2+: powerdomain: add error logs

 arch/arm/mach-omap2/cpuidle34xx.c         |   58 ++--
 arch/arm/mach-omap2/cpuidle44xx.c         |   24 +-
 arch/arm/mach-omap2/omap-hotplug.c        |    2 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   39 +-
 arch/arm/mach-omap2/pm-debug.c            |   15 +-
 arch/arm/mach-omap2/pm.c                  |   62 ---
 arch/arm/mach-omap2/pm.h                  |    1 -
 arch/arm/mach-omap2/pm24xx.c              |   14 +-
 arch/arm/mach-omap2/pm34xx.c              |   75 ++--
 arch/arm/mach-omap2/pm44xx.c              |   24 +-
 arch/arm/mach-omap2/powerdomain.c         |  594 ++++++++++++++++++++++++++---
 arch/arm/mach-omap2/powerdomain.h         |  137 +++++---
 12 files changed, 746 insertions(+), 299 deletions(-)

-- 
1.7.7.6

