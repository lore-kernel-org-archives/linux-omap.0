From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2.6.17-rc3-omap] omap_cf works better
Date: Wed, 3 May 2006 07:45:13 -0700
Message-ID: <200605030745.13625.david-b@pacbell.net>
References: <200605011404.16645.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200605011404.16645.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Monday 01 May 2006 2:04 pm, David Brownell wrote:
> 
> There's still something way goofy going on.  The driver
> mostly behaves, but under much load something will access
> a bogus (and unmapped) kernel address, causing trouble.
> I suspect that's in the pcmcia core, not omap_cf.

More info on this problem.  With PREEMPT enabled, the access
came when testing "current" for the current preempt count,
while switching IRQ handlers in the IDE system.  (At least,
during the time I managed to get a decent stack trace.)

With it disabled, the fault was a "scheduling while atomic"
error ... but the "current->comm" was bogus, ditto the value
of preempt_count().  dump_stack() didn't work...

In both cases it looked as if "current" had become garbage.

So I'm pretty comfortable thinking the issue isn't omap_cf.

But the real problem could be a variety of other places,
and I don't have time to chase it down.  Maybe someone else
has some strange failures to report, so clues could add up.
I'm not sure if the problem is only in the OMAP tree; or if
it only affects CF card access.

- Dave
