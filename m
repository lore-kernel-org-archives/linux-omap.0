From: Marc Titinger <mtitinger@baylibre.com>
Subject: [PATCH 0/2] Trace: PM: promote event 'power_domain_target' to generic power domains.
Date: Fri, 25 Sep 2015 15:22:23 +0200
Message-ID: <1443187345-14834-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: khilman@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net
Cc: linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>
List-Id: linux-omap@vger.kernel.org

- change arg3 to a state name string: we got the current CPU from the trace
backend already. This also prepares for multiple/named states in the power
domain.

- tested with Juno Dev Platform

<idle>-0     [000]    42.395510: power_domain_target:  a53_pd index=0 'cluster-sleep-0'
<idle>-0     [000]    42.395528: cpu_idle:             state=4294967295 cpu_id=0
<idle>-0     [000]    42.395668: cpu_idle:             state=2 cpu_id=0

- compiled for Omap2+

Depends on this patch set from Axel Haslam:

[v7,1/5] PM / Domains: prepare for multiple states
[v7,2/5] PM / Domains: core changes for multiple states
[v7,3/5] PM / Domains: make governor select deepest state
[v7,4/5] ARM: imx6: pm: declare pm domain latency on power_state struct.
[v7,5/5] PM / Domains: remove old power on/off latencies.


Marc Titinger (2):
  Trace: PM: promote event 'power_domain_target' to generic power
    domains.
  arm: omap2+: PM: change trace_power_domain_target event format.

 arch/arm/mach-omap2/powerdomain.c | 32 ++++++++++++++++++++------------
 drivers/base/power/domain.c       |  9 +++++++++
 include/trace/events/power.h      | 29 +++++++++++++++--------------
 3 files changed, 44 insertions(+), 26 deletions(-)

-- 
1.9.1

