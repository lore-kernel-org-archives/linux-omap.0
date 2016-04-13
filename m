From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: wakeupgen: Add comment for unhandled FROZEN
 transitions
Date: Wed, 13 Apr 2016 14:32:26 -0700
Message-ID: <20160413213226.GF5995@atomide.com>
References: <1459774517-58943-1-git-send-email-anna-maria@linutronix.de>
 <570290DA.2050100@oracle.com>
 <20160407170146.GK16484@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160407170146.GK16484@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: santosh shilimkar <santosh.shilimkar@oracle.com>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>, linux-kernel@vger.kernel.org, rt@linutronix.de, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [160407 10:04]:
> * santosh shilimkar <santosh.shilimkar@oracle.com> [160404 09:06]:
> > On 4/4/2016 5:55 AM, Anna-Maria Gleixner wrote:
> > >FROZEN hotplug notifiers are not handled and do not have to be. Insert
> > >a comment to remember that the lack of the FROZEN transitions is no
> > >accident.
> > >
> > >Cc: Tony Lindgren <tony@atomide.com>
> > >Cc: Santosh Shilimkar <ssantosh@kernel.org>
> > >Cc: linux-omap@vger.kernel.org
> > >Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > >---
> > Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> 
> Yeah looks good to me too, will apply for v4.7 when I get through the
> pending fixes here first.

Applying into omap-for-v4.7/soc thanks.

Tony
