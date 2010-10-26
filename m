From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 11:56:57 -0500
Message-ID: <AANLkTinrmhBkjnXE+xQGgrsv_OR_ckz=dyH4EoDB59X_@mail.gmail.com>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
	<1288049630-10947-1-git-send-email-trenn@suse.de>
	<20101026071020.GC13036@elte.hu>
	<AANLkTikWCLTgAGJJ_eH0e016kPfB2K8LtR9g25wbPJXF@mail.gmail.com>
	<4CC6FC03.708@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49753 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab0JZQ46 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Oct 2010 12:56:58 -0400
In-Reply-To: <4CC6FC03.708@linux.intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Renninger <trenn@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> I would like to see a slightly more advanced tracepoint do the runtime pm
> framework;
> specifically I'd like to see the "comm" of the process that's taking a
> refcount on a device
> (that way, powertop can track which process keeps a device busy)
>
>
Yes, the "comm" for this tracepoint should be the runtime_pm workqueue.
To track responsabilities, I'm making another tracepoint, that traces
the rpm_get/put.

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 0f38447..54d9911 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -792,7 +792,7 @@ EXPORT_SYMBOL_GPL(pm_request_resume);
 int __pm_runtime_get(struct device *dev, bool sync)
 {
        int retval;

+       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
        atomic_inc(&dev->power.usage_count);
        retval = sync ? pm_runtime_resume(dev) : pm_request_resume(dev);

@@ -813,6 +813,7 @@ int __pm_runtime_put(struct device *dev, bool sync)
 {
        int retval = 0;

+       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)-1);
        if (atomic_dec_and_test(&dev->power.usage_count))
                retval = sync ? pm_runtime_idle(dev) : pm_request_idle(dev);

@@ -1065,6 +1066,7 @@ void pm_runtime_forbid(struct device *dev)
                goto out;

        dev->power.runtime_auto = false;
+       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)+1);
        atomic_inc(&dev->power.usage_count);
        __pm_runtime_resume(dev, false);

@@ -1086,6 +1088,7 @@ void pm_runtime_allow(struct device *dev)
                goto out;

        dev->power.runtime_auto = true;
+       trace_runtime_pm_usage(dev, atomic_read(&dev->power.usage_count)-1);
        if (atomic_dec_and_test(&dev->power.usage_count))
                __pm_runtime_idle(dev);
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index ea514eb..813229c 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -100,6 +100,29 @@ TRACE_EVENT(runtime_pm_status,
        TP_printk("driver=%s dev=%s prev_status=%s status=%s",
__get_str(drivername),__get_str(devname),
                  show_rpm_status_name(__entry->prev_status),
show_rpm_status_name(__entry->status))
 );
+TRACE_EVENT(runtime_pm_usage,
+
+       TP_PROTO(struct device *dev, int new_usage),
+
+       TP_ARGS(dev, new_usage),
+
+       TP_STRUCT__entry(
+               __string(devname,dev_name(dev))
+               __string(drivername,dev_driver_string(dev))
+               __field(u32, prev_usage)
+               __field(u32, usage)
+       ),
+
+       TP_fast_assign(
+               __assign_str(devname, dev_name(dev));
+               __assign_str(drivername, dev_driver_string(dev));
+               __entry->prev_usage = (u32)atomic_read(&dev->power.usage_count);
+               __entry->usage = (u32)new_usage;
+       ),
+
+       TP_printk("driver=%s dev=%s prev_usage=%d usage=%s",
__get_str(drivername),__get_str(devname),
+                 __entry->prev_usage, __entry->usage)
+);
-- 
Pierre
