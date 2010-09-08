From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Wed, 8 Sep 2010 08:53:33 +0200
Message-ID: <20100908065333.GG3439@elte.hu>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Thomas Renninger <trenn@suse.de>, Arjan van de Ven <arjan@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, arjan@infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


* Jean Pihet <jean.pihet@newoldbits.com> wrote:

> Hi,
> 
> Here is a patch proposal for adding new trace events for power management.
> Note: thread restarted after the initial discussions on LKML.

Also mind including the ACPI tracepoints we talked about? That way a lot 
more people could test it, etc.

	Ingo
