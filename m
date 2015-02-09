From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/2] ARM: omap2+: omap_hwmod: Fix false lockdep warning
Date: Mon, 9 Feb 2015 10:23:32 +0100
Message-ID: <20150209092332.GO5029@twins.programming.kicks-ass.net>
References: <1423226916-18804-1-git-send-email-peter.ujfalusi@ti.com>
 <20150206141346.GP21418@twins.programming.kicks-ass.net>
 <54D4E64C.7060208@ti.com>
 <20150206183205.GS21418@twins.programming.kicks-ass.net>
 <54D5154F.8080208@ti.com>
 <54D86F74.7070703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54D86F74.7070703@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, linux-omap@vger.kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org, balbi@ti.com, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 09, 2015 at 10:27:32AM +0200, Peter Ujfalusi wrote:
> As I recall there is a plan to remove the hwmod static database and move it or
> generate it from DT? Not sure when and how this will be done, but will it
> affect the lockdep_set_class() way?

Yes, struct lock_class_key wants to be in static storage.

So you could still allocate a few of those statically and then use them
where appropriate, but it'd going to be more work.

The advantage of having the 1:1 relation is that any parent hierarchy
works naturally.
