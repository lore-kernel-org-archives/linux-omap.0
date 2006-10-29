From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: Git tree updated to 2.6.19-rc2
Date: Mon, 30 Oct 2006 00:09:05 +0200 (EET)
Message-ID: <20061030.000905.94155970.Hiroshi.DOYU@nokia.com>
References: <20061023203925.GC11967@atomide.com> <453E3C75.6060605@gmail.com>
	<20061027125013.GB25245@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061027125013.GB25245@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

From: "ext tony@atomide.com" <tony@atomide.com>
Subject: Re: Git tree updated to 2.6.19-rc2
Date: Fri, 27 Oct 2006 15:50:17 +0300

> * Dirk Behme <dirk.behme@googlemail.com> [061024 19:16]:
> > Tony Lindgren wrote:
> > >- CONFIG_DEBUG_LL hangs system
> > 
> > For reference see
> > 
> > http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008025.html
> > 
> > and
> > 
> > http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008054.html
> > 
> > for an ugly workaround if you really need it. I really have
> > no clue what is broken here.
> 
> Sounds like some clock is not enabled somewhere and serial write hangs.
>  
> > >- BUG in omap1_mbox_enable_irq
> > 
> > I think you mean
> > 
> > Unbalanced enable for IRQ 10
> > BUG: warning at kernel/irq/manage.c:118/enable_irq()
> > 
> > printed in bootmessages.
> > 
> > I spent some minutes for this as well. It is MPU "dsp"
> > interrupt which is enabled in omap1_mbox_enable_irq() by
> > 
> > enable_irq(mbox->irq);
> > 
> > In kernel/irq/manage.c function enable_irq() checks for
> > desc->depth and if it is 0 it prints above message. Seems
> > that desc->depth has to be >= 1.
> > 
> > The comment tells us
> > 
> > *	Undoes the effect of one call to disable_irq().  If this
> > *	matches the last disable, processing of interrupts on this
> > *	IRQ line is re-enabled.
> > 
> > so seems that before calling enable_irq() at least one
> > disable_irq() is needed.
> > 
> > I don't know if patch in attachment is a valid patch or only
> > a workaround. What do you think?
> > 
> > Best regards
> > 
> > Dirk
> > 
> 
> > --- arch/arm/plat-omap/mailbox.c_orig	2006-10-24 18:08:06.000000000 +0200
> > +++ arch/arm/plat-omap/mailbox.c	2006-10-24 18:10:58.000000000 +0200
> > @@ -237,6 +237,7 @@ static int omap_mbox_init(struct omap_mb
> >  		       "failed to register mailbox interrupt:%d\n", ret);
> >  		goto fail1;
> >  	}
> > +	disable_mbox_irq(mbox, IRQ_RX);
> >  	enable_mbox_irq(mbox, IRQ_RX);
> >  
> >  	spin_lock_init(&mbox->lock);
> > 
> 
> Let's see what Toshihiro and Hiroshi think.

I guess that the above should work for now but I think that there's
another way, for example, I can have initialization flag in
enable_mbox_irq() in omap1, though I am sure that there's better way.

    Hiroshi DOYU
