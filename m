From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/4] cpupower: Add cpupower-idle-info manpage
Date: Fri, 16 Dec 2011 15:35:51 +0100
Message-ID: <1324046154-64824-2-git-send-email-trenn@suse.de>
References: <1324046154-64824-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1324046154-64824-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: linux@dominikbrodowski.net
Cc: cpufreq@vger.kernel.org, Thomas Renninger <trenn@suse.de>, linux-arm-kernel@lists.infradead.org, jean.pihet@newoldbits.com, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The last missing manpage for cpupower tools.

More info about other architecture's sleep state specialities would be great.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: linux-arm-kernel@lists.infradead.org
CC: jean.pihet@newoldbits.com
CC: linux-omap@vger.kernel.org
CC: linux-pm@lists.linux-foundation.org
CC: linux-acpi@vger.kernel.org
CC: cpufreq@vger.kernel.org
CC: linux@dominikbrodowski.net
---
 tools/power/cpupower/man/cpupower-idle-info.1 |   90 +++++++++++++++++++++++++
 1 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100644 tools/power/cpupower/man/cpupower-idle-info.1

diff --git a/tools/power/cpupower/man/cpupower-idle-info.1 b/tools/power/cpupower/man/cpupower-idle-info.1
new file mode 100644
index 0000000..4178eff
--- /dev/null
+++ b/tools/power/cpupower/man/cpupower-idle-info.1
@@ -0,0 +1,90 @@
+.TH "CPUPOWER-IDLE-INFO" "1" "0.1" "" "cpupower Manual"
+.SH "NAME"
+.LP
+cpupower idle\-info \- Utility to retrieve cpu idle kernel information
+.SH "SYNTAX"
+.LP
+cpupower [ \-c cpulist ] idle\-info [\fIoptions\fP]
+.SH "DESCRIPTION"
+.LP
+A tool which prints out per cpu idle information helpful to developers and interested users.
+.SH "OPTIONS"
+.LP
+.TP
+\fB\-f\fR \fB\-\-silent\fR
+Only print a summary of all available C-states in the system.
+.TP
+\fB\-e\fR \fB\-\-proc\fR
+deprecated.
+Prints out idle information in old /proc/acpi/processor/*/power format. This
+interface has been removed from the kernel for quite some time, do not let
+further code depend on this option, best do not use it.
+
+.SH IDLE\-INFO DESCRIPTIONS
+CPU sleep state statistics and descriptions are retrieved from sysfs files,
+exported by the cpuidle kernel subsystem. The kernel only updates these
+statistics when it enters or leaves an idle state, therefore on a very idle or
+a very busy system, these statistics may not be accurate. They still provide a
+good overview about the usage and availability of processor sleep states on
+the platform.
+
+Be aware that the sleep states as exported by the hardware or BIOS and used by
+the Linux kernel may not exactly reflect the capabilities of the
+processor. This often is the case on the X86 architecture when the acpi_idle
+driver is used. It is also possible that the hardware overrules the kernel
+requests, due to internal activity monitors or other reasons.
+On recent X86 platforms it is often possible to read out hardware registers
+which monitor the duration of sleep states the processor resided in. The
+cpupower monitor tool (cpupower\-monitor(1)) can be used to show real sleep
+state residencies. Please refer to the architecture specific description
+section below.
+
+.SH IDLE\-INFO ARCHITECTURE SPECIFIC DESCRIPTIONS
+.SS "X86"
+POLL idle state
+
+If cpuidle is active, X86 platforms have one special idle state.
+The POLL idle state is not a real idle state, it does not save any
+power. Instead, a busy\-loop is executed doing nothing for a short period of
+time. This state is used if the kernel knows that work has to be processed
+very soon and entering any real hardware idle state may result in a slight
+performance penalty.
+
+There exist two different cpuidle drivers on the X86 architecture platform:
+
+"acpi_idle" cpuidle driver
+
+The acpi_idle cpuidle driver retrieves available sleep states (C\-states) from
+the ACPI BIOS tables (from the _CST ACPI function on recent platforms or from
+the FADT BIOS table on older ones).
+The C1 state is not retrieved from ACPI tables. If the C1 state is entered,
+the kernel will call the hlt instruction (or mwait on Intel).
+
+"intel_idle" cpuidle driver
+
+In kernel 2.6.36 the intel_idle driver was introduced.
+It only serves recent Intel CPUs (Nehalem, Westmere, Sandybridge, Atoms or
+newer). On older Intel CPUs the acpi_idle driver is still used (if the BIOS
+provides C\-state ACPI tables).
+The intel_idle driver knows the sleep state capabilities of the processor and
+ignores ACPI BIOS exported processor sleep states tables.
+
+.SH "REMARKS"
+.LP
+By default only values of core zero are displayed. How to display settings of
+other cores is described in the cpupower(1) manpage in the \-\-cpu option
+section.
+.SH REFERENCES
+http://www.acpi.info/spec.htm
+.SH "FILES"
+.nf
+\fI/sys/devices/system/cpu/cpu*/cpuidle/state*\fP
+\fI/sys/devices/system/cpu/cpuidle/*\fP
+.fi
+.SH "AUTHORS"
+.nf
+Thomas Renninger <trenn@suse.de>
+.fi
+.SH "SEE ALSO"
+.LP
+cpupower(1), cpupower\-monitor(1), cpupower\-info(1), cpupower\-set(1)
-- 
1.7.6.1

