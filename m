From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] misc. OMAP PM updates for v3.1
Date: Mon, 27 Jun 2011 09:50:15 -0700
Message-ID: <87oc1jcj7c.fsf@ti.com>
References: <87vcvw5akk.fsf@ti.com> <20110627112843.GN23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110627112843.GN23145@atomide.com> (Tony Lindgren's message of
	"Mon, 27 Jun 2011 04:28:43 -0700")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [110623 17:32]:
>> Tony,
>> 
>> Please pull the following misc. OMAP PM updates targetted for v3.1.
>> 
>> This branch is based on your 'fixes' branch due to some dependencies.
>>       OMAP2: PM debug: move wakeup timer into clockevent code
>
> This won't work with the devel-timer branch. I think we should just
> drop it for now based on what I mentioned in the other thread.

Hmm, so it's not just the wakeup timer that conflicts between
devel-timer and my pm-misc branch.

My branch also removes a bunch of other stuff from pm-debug.c and pm.h
so it has overlapping changes with your devel-timer branch.

The conflicts are easy enough to resolve since both branches are just
removing code.

Is your devel-timer branch stable now?  Should I rebase my branch on top
of devel-timer?  or can you just handle the conflicts?

Kevin
