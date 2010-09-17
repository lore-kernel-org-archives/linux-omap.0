From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Sat, 18 Sep 2010 00:26:58 +0200
Message-ID: <201009180026.59482.trenn@suse.de>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com> <201009171736.14170.trenn@suse.de> <20100917162412.GB3341@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20100917162412.GB3341@elte.hu>
Sender: linux-trace-users-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Arjan van de Ven <arjan@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, arjan@infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 17 September 2010 18:24:12 Ingo Molnar wrote:
> 
> * Thomas Renninger <trenn@suse.de> wrote:
> 
> > On Friday 17 September 2010 16:24:59 Ingo Molnar wrote:

> [ You dont even have to document it, as good code is self-explanatory ;-) ]
I recently posted a patch exporting some things through /sys/kernel/debug/...
Greg complained that a file for Documentation/ABI/{testing,stable}/* is missing
and I fully agree.
If different userspace apps should make use of this (in above case nobody
than my debug userspace tool will...) and this should be called something like an API,
it should be documented and if something changes, it should
first be marked deprecated, etc.

     Thomas
