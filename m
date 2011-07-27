From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC/PATCH v2] PM / Runtime: allow _put_sync() from interrupts-disabled context
Date: Wed, 27 Jul 2011 11:22:07 +0200
Message-ID: <201107271122.07701.rjw@sisk.pl>
References: <1311371188-28879-1-git-send-email-khilman@ti.com> <201107240102.09698.rjw@sisk.pl> <87r55cpnwo.fsf@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54203 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754024Ab1G0JUl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jul 2011 05:20:41 -0400
In-Reply-To: <87r55cpnwo.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Stern <stern@rowland.harvard.edu>, Colin Cross <ccross@android.com>

On Wednesday, July 27, 2011, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Friday, July 22, 2011, Kevin Hilman wrote:
> >> Currently the use of pm_runtime_put_sync() is not safe from
> >> interrupts-disabled context because rpm_idle() will release the
> >> spinlock and enable interrupts for the idle callbacks.  This enables
> >> interrupts during a time where interrupts were expected to be
> >> disabled, and can have strange side effects on drivers that expected
> >> interrupts to be disabled.
> >> 
> >> This is not a bug since the documentation clearly states that only
> >> _put_sync_suspend() is safe in IRQ-safe mode.
> >> 
> >> However, pm_runtime_put_sync() could be made safe when in IRQ-safe
> >> mode by releasing the spinlock but not re-enabling interrupts, which
> >> is what this patch aims to do.
> >> 
> >> Problem was found when using some buggy drivers that set
> >> pm_runtime_irq_safe() and used _put_sync() in interrupts-disabled
> >> context.
> >> 
> >> The offending drivers have been fixed to use _put_sync_suspend(),
> >> But this patch is an RFC to see if it might make sense to allow
> >> using _put_sync() from interrupts-disabled context.
> >
> > OK, I'm going to take this for 3.2.
> >
> 
> OK, great.  Thanks.
> 
> Might want to just drop the last paragraph from the changelog since it
> doesn't really belong in the permanant history.

OK

Thanks,
Rafael
