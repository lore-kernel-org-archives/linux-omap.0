From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 04/19] ARM: omap1: convert to using readl/writel
	instead of volatile struct
Date: Wed, 18 May 2011 08:56:25 +0100
Message-ID: <20110518075625.GA12302@n2100.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1ZG-0003DV-PA@rmk-PC.arm.linux.org.uk>
	<BANLkTinG0BmBJZTWr-FrBzANg-MbdsghkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <BANLkTinG0BmBJZTWr-FrBzANg-MbdsghkA@mail.gmail.com>
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
Cc: John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, May 17, 2011 at 10:59:28PM +0100, Catalin Marinas wrote:
> On 16 May 2011 18:26, Russell King - ARM Linux <linux@arm.linux.org.uk> w=
rote:
> > --- a/arch/arm/mach-omap1/time.c
> > +++ b/arch/arm/mach-omap1/time.c
> ...
> > =A0static inline unsigned long notrace omap_mpu_timer_read(int nr)
> > =A0{
> > - =A0 =A0 =A0 volatile omap_mpu_timer_regs_t* timer =3D omap_mpu_timer_=
base(nr);
> > - =A0 =A0 =A0 return timer->read_tim;
> > + =A0 =A0 =A0 omap_mpu_timer_regs_t __iomem *timer =3D omap_mpu_timer_b=
ase(nr);
> > + =A0 =A0 =A0 return readl(&timer->read_tim);
> > =A0}
> =

> We should start using the *_relaxed() accessors a bit more to avoid
> the barriers overhead in the standard I/O accessors.

I thought about that, but when you look at patch 6, it'd change this.
I wanted to use the same accessor here as it ends up with in patch 6.
