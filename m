From: tony@atomide.com
Subject: Re: patches for fsample/850
Date: Thu, 13 Apr 2006 03:17:06 -0700
Message-ID: <20060413101705.GA3969@atomide.com>
References: <20060407220658.GA19801@localhost.localdomain>
	<20060408110036.34284.qmail@web32904.mail.mud.yahoo.com>
	<20060408154425.GA24843@localhost.localdomain>
	<20060409183557.GF5032@atomide.com>
	<20060409210515.GA1877@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060409210515.GA1877@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Brian Swetland <swetland@google.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Brian Swetland <swetland@google.com> [060409 14:05]:
> [tony@atomide.com]
> 
> > Then does it compile and boot for p2 and fsample both selected?
> 
> Probably not -- is there something like cpu_is_*() that I could
> use to make this conditional at runtime?

You can use machine_is_xxx() which also work during runtime based on the
machine id.
  
> > Also, could you please do one patch for the core support, and then
> > another patch for files that don't touch the omap core files?
> > 
> > That way we can send you patch directly upstream when we merge next
> > time. Otherwise I have to redo the patch to strip out the drivers when
> > we merge as not many omap drivers are yet merged with the mainline tree.
> 
> Sure.  I'll clean up the above and break it into two pieces.

Great, thanks.

Tony
