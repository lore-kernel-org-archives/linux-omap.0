From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Tue, 25 Jan 2011 13:04:22 +0000
Message-ID: <20110125130422.GH13300@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com>
	<20110125114635.GB13300@n2100.arm.linux.org.uk>
	<236d45e400a960cc3b32db538b3a79ae@mail.gmail.com>
	<20110125121655.GD13300@n2100.arm.linux.org.uk>
	<4534e82bf14eeea9f96769df760df5ae@mail.gmail.com>
	<20110125125656.GG13300@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110125125656.GG13300@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: ccross@android.com, catalin.marinas@arm.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linus.ml.walleij@gmail.com
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 25, 2011 at 12:56:56PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 25, 2011 at 06:06:27PM +0530, Santosh Shilimkar wrote:
> > Ok. I missed some information my last email.
> > The SCU power status programming is used to take CPU in/out
> > of coherency as an alternative to SMP bit. We don't
> > have an access to SMP bit on OMAP4. ARM has already
> > confirmed SCU programming is same as SMP bit enable/disable.
> > 
> > I don't know how safe is to use spin lock when one CPU is
> > goes out of coherency after programming the power state. The
> > spin lock release may not even be visible to other CPU.
> 
> Erm, I do hope that's not the case, as that means it is unsafe for CPUs in
> a SMP system to write to this register without them potentially trampling
> over each other.
> 
> If it is the case, then the solutions are either:
> 1. Fix the hardware so that coherency requests only yet turned off
>    when entering the WFI state.
> 2. Fix the hardware such that each CPU has a separate register.

Actually, we can do this safely - byte stores are permitted to SCU
registers probably for this very reason.
