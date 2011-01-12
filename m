From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 3/9] X86/perf: fix power:cpu_idle double end events and throw cpu_idle events from the cpuidle layer
Date: Wed, 12 Jan 2011 16:16:54 +0100
Message-ID: <201101121616.54613.trenn@suse.de>
References: <1294396190-23031-1-git-send-email-trenn@suse.de> <1294396190-23031-4-git-send-email-trenn@suse.de> <alpine.LFD.2.02.1101120141330.19140@x980>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1101120141330.19140@x980>
Sender: linux-perf-users-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, j-pihet@ti.com, Robert Schoene <robert.schoene@tu-dresden.de>, Frederic Weisbecker <fweisbec@gmail.com>, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 12 January 2011 07:42:59 Len Brown wrote:
> I'm happy to see the trace point move up into cpuidle from intel_idle.
> 
> If somebody is picking this up in a perf tree,
> Acked-by: Len Brown <len.brown@intel.com>
> 
> else I can put it in the idle tree, let me know.
I didn't know you have an idle tree.

If you can push this one through the idle tree that would be great.

I'll go through the rest of my patches and resubmit
in some days as soon as some things are clarified.

But I need this one to still be included in .38.
Please tell me if this could be a problem.

Thanks,

  Thomas
