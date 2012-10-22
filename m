From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: RT throttling and suspend/resume (was Re: [PATCH] i2c: omap:
 revert "i2c: omap: switch to threaded IRQ support")
Date: Mon, 22 Oct 2012 11:52:21 +0200
Message-ID: <1350899541.2768.82.camel@twins>
References: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
 <CAM=Q2csHTbR4rBe1HNr5-M3sG5wgdCv6dCnGLmNQEwo1gjCSGg@mail.gmail.com>
 <20121016133356.GG21801@arwen.pp.htv.fi>
 <87ipaanljt.fsf_-_@deeprootsystems.com>
 <20121017140002.GI11394@arwen.pp.htv.fi>
 <20121017143534.GJ11394@arwen.pp.htv.fi>
 <87txtsitpt.fsf@deeprootsystems.com>
 <20121018055136.GF11137@arwen.pp.htv.fi> <1350655227.2768.11.camel@twins>
 <87391ahvao.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87391ahvao.fsf@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, Wolfram Sang <w.sang@pengutronix.de>, balbi@ti.com, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, 2012-10-19 at 16:54 -0700, Kevin Hilman wrote:

> So I did the same thing for my ARM SoC, and it definitley stops the RT
> throttling.  
> 
> However, it has the undesriable (IMO) side effect of making timed printk
> output rather unhelpful for debugging suspend/resume since printk time
> stays constant throughout suspend/resume no matter how long you
> sleep. :(
> 
> So does that mean we have to choose between useful printk times during
> suspend/resume or functioning IRQ threads during suspend/resume ?

Urgh.. this was not something I considered. This being primarily the
sched_clock infrastructure and such.

So what exactly is the problem with the suspend resume thing (its not
something I've ever debugged), is all you need a clean break between pre
and post suspend, or do you need the actual time the machine was gone?
