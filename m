From: Imre Deak <imre.deak@nokia.com>
Subject: Re: OMAP5912 touchscreen irq not working
Date: Wed, 31 May 2006 19:46:31 +0300
Message-ID: <1149093991.31999.66.camel@mammoth.research.nokia.com>
References: <4477F2BA.3080907@gmail.com> <44793CF9.2050101@nokia.com>
	<447DB9CC.2070808@gmail.com> <200605310905.31864.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200605310905.31864.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wed, 2006-05-31 at 09:05 -0700, ext David Brownell wrote:
> On Wednesday 31 May 2006 8:44 am, Dirk Behme wrote:
> > I think it's wrong to get ads7846_irq() called already while 
> > init without screen touched? And then this irq seems to be 
> > locked after first touch.
> 
> Locking out after first touch is a problem, of course.  
> 
> IRQ during init happens with some hardware; I recall
> concluding it wasn't a problem here, though the details
> of that have been discarded like a used coffee filter.
> 
> ISTR one issue is that sampling will trigger an IRQ,
> so the driver needs to throttle the IRQs.

Yes, during init we send send a couple of commands - with IRQs disabled
- to put the device in the initial waiting-for-IRQ state. That will also
result in a latched interrupt which will be delivered as soon as we
enable the IRQ again.

This spurious IRQ could be avoided by set_irq_type(IRQT_NONE) which
would prevent even the latching of it.

In the current code this shouldn't be a problem, since in the IRQ
handler we check the actual pen status.

> > Please correct me if I'm wrong here, but with irq called at 
> > init without screen touched, then after one touch locked, 
> > and permanently called ads7846_rx() throwing away all 
> > samples, it seems to me that there is anything basically 
> > wrong with this new code? At least on OSK with mistral.
> 
> There were glitches related to the problem with irqs not
> getting disabled on request, with comments along the lines
> of "remove this when the irqs work right" ... I think it's
> time to maybe sort that issue out.

Yes, I think the irq_disabled flag is not necessary any more.

> That said, this problem did not exist before the GPIO IRQ
> patches were merged ... I certainly saw correct IRQ behavior
> from my testing.

Might be, but this looks more to me to do something with values returned
to the _rx() function. Since it's continually called I suppose it never
detects the pen up which it determines from the pressure value. Would
help if you could enable the pr_debug in the _rx() function to see the
returned values.

--Imre

> 
> - Dave
