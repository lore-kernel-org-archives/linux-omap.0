From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 4/9] cpuidle: Introduce .abbr (abbrevation) for cpuidle states
Date: Thu, 13 Jan 2011 00:39:18 +0100
Message-ID: <201101130039.19519.trenn@suse.de>
References: <1294396190-23031-1-git-send-email-trenn@suse.de> <201101121437.51122.trenn@suse.de> <alpine.LFD.2.02.1101121705130.19754@x980>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1101121705130.19754@x980>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, j-pihet@ti.com, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 12 January 2011 23:25:12 Len Brown wrote:
> > > If the display tools can only handle 3 characters,
> > > then why not have them simply use the 1st 3 characters
> > > of the existing name field?
> 
> > You mean use:
> > C3 NHM
> > instead of
> > NHM-C3
> > for intel_idle?
> 
> Yes.
> is there a reason that would be a problem?
A much more elegant solution came to my mind:
I'll rewrite the perf timechart patch to do:
Title:   C-stateName1 [1] , C-stateName2 [2]
and later I will refer to the states by 1, 2, ...
Eventually a:
Description:
[1] C-stateDescription1
[2] C-stateDescription2
...
can be put somewhere as well.

Please ignore this patch.

Stupid that I didn't think of that in the first place.

Thanks,

   Thomas
