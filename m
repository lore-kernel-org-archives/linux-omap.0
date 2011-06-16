From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: pm: Downgrade WARN for no wakeup source
Date: Fri, 17 Jun 2011 01:46:36 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D563EF1@dbde02.ent.ti.com>
References: <1308229940-27025-1-git-send-email-premi@ti.com>
	<877h8lsswk.fsf@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D563E79@dbde02.ent.ti.com>
	<87vcw5k510.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87vcw5k510.fsf@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Hilman, Kevin 
> Sent: Thursday, June 16, 2011 11:55 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH] omap3: pm: Downgrade WARN for no wakeup source
> 
> "Premi, Sanjeev" <premi@ti.com> writes:
> 
> >> -----Original Message-----
> >> From: Hilman, Kevin 
> >> Sent: Thursday, June 16, 2011 8:52 PM
> >> To: Premi, Sanjeev
> >> Cc: linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org
> >> Subject: Re: [PATCH] omap3: pm: Downgrade WARN for no wakeup source
> >> 
> >> Hi Sanjeev,
> >> 
> >> Sanjeev Premi <premi@ti.com> writes:
> >> 
> >> > When multiple wakeup sources are defined in a system,
> >> > there is a small window, when more than one source
> >> > can trigger wakeup interrupt.
> >> >
> >> > In the current implementation, the do-while() loop
> >> > can handle all wakeup sources that are recorded when
> >> > probing the status register in prcm_interrupt_handler().
> >> >
> >> > When the ISR executes due to next queued wakeup, it
> >> > there is nothing to be handled and value of "c" is 0.
> >> 
> >> Thanks for tracking this one down.
> >> 
> >> However, It's still not clear to me what is happening here.
> >> 
> >> Why is the IRQ firing if there is nothing to be handled?  
> >> That suggests
> >> to me that the IRQ status is not properly being cleared.
> >
> > [SP] On the contrary the IRQ status is actually getting cleared,
> >      but there are more than "1" PRCM interrupts queued.
> >
> >      The do-while() clears all the interrupt sources that
> >      are flagged in the status register.
> >
> >      When the next wakeup interrupt is getting processed, the
> >      status register doesn't contain any "source" to handle.
> 
> Still confused.
> 
> If a wakeup interrupt is fired, it was caused by something.  
> 
> IOW, if "the status register doesn't contain any source",  how is
> 
> 		if (irqstatus_mpu & (OMAP3430_WKUP_ST_MASK |
> 				     OMAP3430_IO_ST_MASK)) 
> 
> ever true?

[sp] I had been hesitant to say "nesting" because the wakeup
     interrupts seem to be independent of each other. But now
     I think - from SW perspective, it should/could be considered
     as nesting.

~sanjeev

> 
> Kevin
> 
