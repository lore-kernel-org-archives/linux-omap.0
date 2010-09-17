From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Fri, 17 Sep 2010 17:36:13 +0200
Message-ID: <201009171736.14170.trenn@suse.de>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com> <AANLkTi=W_Lo2m=hkA2F48oUziqGzt4Tr8y6KhfgqRnbz@mail.gmail.com> <20100917142459.GA28124@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20100917142459.GA28124@elte.hu>
Sender: linux-trace-users-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Arjan van de Ven <arjan@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, arjan@infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 17 September 2010 16:24:59 Ingo Molnar wrote:
> 
> * Jean Pihet <jean.pihet@newoldbits.com> wrote:
> 
> > > Apropos documentation..., are the power trace events documented
> > > somewhere?
> >
> > No. We need something like Documentation/trace/events-kmem.txt. I
> > can write that with for the new power API.
> Such a patch introducing events-power.txt would be most welcome!
Better wait a bit...
As soon as it exists, things are harder to change.
As long as there isn't an API documented, there doesn't exist one
(yes we want to have perf timechart, etc. still functional/compatible,
but still, better let's do not the same mistake with some quick shots).

Whatabout adding perf/trace interfaces to:
Documentation/ABI/*/perf-xy

    Thomas
