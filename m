From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] ARM: Update SMP_ON_UP code to detect A9MPCore with 1 CPU
 devices
Date: Fri, 2 Aug 2013 16:48:58 +0100
Message-ID: <20130802154857.GD5292@mudshark.cambridge.arm.com>
References: <1375381033-13220-1-git-send-email-santosh.shilimkar@ti.com>
 <51FBC610.9030900@arm.com> <51FBCEC3.4030207@ti.com>
 <51FBD42A.9040901@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <51FBD42A.9040901@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 02, 2013 at 04:45:46PM +0100, Sudeep KarkadaNagesha wrote:
> On 02/08/13 16:22, Santosh Shilimkar wrote:
> >>> +	@ Core indicates it is SMP.  Check for Aegis SOC where a single
> >>> +	@ Cortex-A9 CPU is present but SMP operations fault.
> >>> +	mov	r4, #0x41000000
> >>> +	orr	r4, r4, #0x0000c000
> >>> +	orr	r4, r4, #0x00000090
> >>> +	teq	r3, r4			@ Check for ARM Cortex-A9
> >>> +	movne	pc, lr			@ Not ARM Cortex-A9,
> >>> +
> >>> +	mrc	p15, 4, r0, c15, c0	@ get SCU base address
> >> Correct me if I am interpreting this wrong, but CRn=15 here which is
> >> IMPLEMENTATION DEFINED registers.
> >>
> >> If not, then I wonder why few platform have to read SCU base from DT or
> >> some header, why not this way ?
> >>
> > I don't know if there is Cortex-A9 based SOC which don't implement SCU
> > CP15 base address register, so can't comment really why not always use
> > CP15 based method. I am not even sure if there are other reasons behind
> > DT usage.
> > 
> I may be wrong, but it's just my understanding as I see that ARM ARM
> clearly states CRn=15 space is IMPLEMENTATION DEFINED registers and we
> can't expect it to work on all IMPLEMENTATIONS.
> 
> I just had a glance at all the usage of CR15 space of CP15 register, its
> either platform specific or under specific errata/condition.
> 
> Will/Dave/Russell can confirm if it's safe to access these registers on
> any implementation or you may need to make it conditional.

I think this an A9-specific register, which reads as 0 on UP A9 and reads as
some form of PERIPH_BASE for SMP parts. The issue I have is when PERIPH_BASE
is zero.

Will
