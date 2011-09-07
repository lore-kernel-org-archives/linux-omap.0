From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 03/11] ARM: pm: some ARMv7 requires a dsb in resume to
	ensure correctness
Date: Wed, 7 Sep 2011 17:19:06 +0100
Message-ID: <20110907161906.GA2327@n2100.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
	<E1Qz6hr-00078J-2k@rmk-PC.arm.linux.org.uk>
	<CAHkRjk65O3wJLazxZeOOQrDuM-XkZXo4fcOuVZf4Jzq9OP3p3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAHkRjk65O3wJLazxZeOOQrDuM-XkZXo4fcOuVZf4Jzq9OP3p3g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 07, 2011 at 04:41:32PM +0100, Catalin Marinas wrote:
> On 1 September 2011 13:49, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Add a dsb after the isb to ensure that the previous writes to the
> > CP15 registers take effect before we enable the MMU.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> > =A0arch/arm/mm/proc-v7.S | =A0 =A01 +
> > =A01 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> > index dec72ee..a773f4e 100644
> > --- a/arch/arm/mm/proc-v7.S
> > +++ b/arch/arm/mm/proc-v7.S
> > @@ -255,6 +255,7 @@ ENTRY(cpu_v7_do_resume)
> > =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r4, c10, c2, 0 =A0@ write PRRR
> > =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r5, c10, c2, 1 =A0@ write NMRR
> > =A0 =A0 =A0 =A0isb
> > + =A0 =A0 =A0 dsb
> =

> Isn't an ISB enough here? We usually have the DSB for some background
> operations like cache maintenance.

That depends whether you're including the effects of the cache
maintanence instructions in this.  The ARM ARM tells me that
a DSB is required to ensure that all cache maintanence is issued
before the dsb is complete at the point that the dsb is executed.

So for architectural compliance, yes, a dsb is required.  The isb
is also required to ensure that instruction cache maintanence is
properly visible.
