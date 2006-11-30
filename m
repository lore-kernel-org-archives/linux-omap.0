From: David Brownell <david-b@pacbell.net>
Subject: Re: CONFIG_PREEMPT_RT patch on Apollon (OMAP2)
Date: Thu, 30 Nov 2006 13:35:23 -0800
Message-ID: <200611301335.23815.david-b@pacbell.net>
References: <11115895.486281164610759448.JavaMail.weblogic@ep_ml20>
	<456B3802.1000101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <456B3802.1000101@gmail.com>
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

On Monday 27 November 2006 11:09 am, Dirk Behme wrote:

> > 1. ethernet flags
> >   - After change from IRQF_RISING to IRQF_HIGH in recent OMAP2 patch. it occurs the GPIO bug message in line 1005.
> >     So I reverted IRQF_RISING as before. then it's working.
> 
> Maybe David has an idea here? [1]

No.  H4 with NFSroot and current GIT works fine for me; that
uses IRQF_TRIGGER_LOW.

The "best" solution would of course be passing the flags in
the IRQ resource, but that'd be more invasive to smc91x and
(eventually) the board init code.  platform_get_irq() doesn't
pass those flags along.

- Dave
