From: jean.pihet@newoldbits.com
Subject: [PATCH 0/2] tools, perf: new power trace API
Date: Wed,  5 Jan 2011 19:49:00 +0100
Message-ID: <1294253342-29056-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
To: mingo@elte.hu, trenn@suse.de, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-perf-users@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Provides:
. calls to machine_suspend trace point,
. API Documentation

The OMAP specific changes will be submitted separately on
the linux-omap ML because:
- the OMAP changes need to be rebased on the latest linux-omap 2.6.37 tree,
- more feedback is needed from the linux-omap folks.

Jean Pihet (2):
  perf: add calls to suspend trace point
  tools, perf: Documentation for the power events API

 Documentation/trace/events-power.txt |   90 ++++++++++++++++++++++++++++++++++
 kernel/power/suspend.c               |    3 +
 2 files changed, 93 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/trace/events-power.txt

-- 
1.7.2.3
