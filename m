From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
Date: Wed, 5 Apr 2017 07:33:19 -0700
Message-ID: <20170405143318.GE13234@atomide.com>
References: <20170328205511.21166-1-d-gerlach@ti.com>
 <20170328205511.21166-3-d-gerlach@ti.com>
 <20170404161151.GS10760@atomide.com>
 <20170405135933.GN23750@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170405135933.GN23750@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [170405 07:02]:
> On Tue, Apr 04, 2017 at 09:11:52AM -0700, Tony Lindgren wrote:
> > Russell,
> > 
> > * Dave Gerlach <d-gerlach@ti.com> [170328 13:57]:
> > > Certain SoCs like Texas Instruments AM335x and AM437x require parts
> > > of the EMIF PM code to run late in the suspend sequence from SRAM,
> > > such as saving and restoring the EMIF context and placing the memory
> > > into self-refresh.
> > > 
> > > One requirement for these SoCs to suspend and enter its lowest power
> > > mode, called DeepSleep0, is that the PER power domain must be shut off.
> > > Because the EMIF (DDR Controller) resides within this power domain, it
> > > will lose context during a suspend operation, so we must save it so we
> > > can restore once we resume. However, we cannot execute this code from
> > > external memory, as it is not available at this point, so the code must
> > > be executed late in the suspend path from SRAM.
> > > 
> > > This patch introduces a ti-emif-sram driver that includes several
> > > functions written in ARM ASM that are relocatable so the PM SRAM
> > > code can use them. It also allocates a region of writable SRAM to
> > > be used by the code running in the executable region of SRAM to save
> > > and restore the EMIF context. It can export a table containing the
> > > absolute addresses of the available PM functions so that other SRAM
> > > code can branch to them. This code is required for suspend/resume on
> > > AM335x and AM437x to work.
> > > 
> > > In addition to this, to be able to share data structures between C and
> > > the ti-emif-sram-pm assembly code, we can automatically generate all of
> > > the C struct member offsets and sizes as macros by making use of the ARM
> > > asm-offsets file. In the same header that we define our data structures
> > > in we also define all the macros in an inline function and by adding a
> > > call to this in the asm_offsets file all macros are properly generated
> > > and available to the assembly code without cluttering up the asm-offsets
> > > file.
> > > 
> > > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> > > ---
> > >  arch/arm/kernel/asm-offsets.c    |   6 +
> > >  drivers/memory/Kconfig           |  10 ++
> > >  drivers/memory/Makefile          |   4 +
> > >  drivers/memory/emif.h            |  17 ++
> > >  drivers/memory/ti-emif-pm.c      | 295 ++++++++++++++++++++++++++++++++++
> > >  drivers/memory/ti-emif-sram-pm.S | 334 +++++++++++++++++++++++++++++++++++++++
> > >  include/linux/ti-emif-sram.h     | 143 +++++++++++++++++
> > >  7 files changed, 809 insertions(+)
> > >  create mode 100644 drivers/memory/ti-emif-pm.c
> > >  create mode 100644 drivers/memory/ti-emif-sram-pm.S
> > >  create mode 100644 include/linux/ti-emif-sram.h
> > > 
> > > diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> > > index 608008229c7d..d728b5660e36 100644
> > > --- a/arch/arm/kernel/asm-offsets.c
> > > +++ b/arch/arm/kernel/asm-offsets.c
> > > @@ -28,6 +28,7 @@
> > >  #include <asm/vdso_datapage.h>
> > >  #include <asm/hardware/cache-l2x0.h>
> > >  #include <linux/kbuild.h>
> > > +#include <linux/ti-emif-sram.h>
> > >  
> > >  /*
> > >   * Make sure that the compiler and target are compatible.
> > > @@ -183,5 +184,10 @@ int main(void)
> > >  #ifdef CONFIG_VDSO
> > >    DEFINE(VDSO_DATA_SIZE,	sizeof(union vdso_data_store));
> > >  #endif
> > > +#if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
> > > +  BLANK();
> > > +  ti_emif_offsets();
> > > +#endif
> > > +
> > >    return 0; 
> > >  }
> > 
> > Does the above look OK to you?
> 
> I'm not going to comment on this yet, but I'll instead comment on the
> newly appeared sram_exec_copy() stuff.
> 
> So, a few years ago, we went to significant effort in ARM land to come
> up with a way to _safely_ copy assembler from the kernel into SRAM,
> because copying code to SRAM that is compiled in thumb mode and then
> executing it is _not_ as simple as memcpy(), cast the pointer to a
> function pointer, and then call the function pointer.
> 
> The SRAM stuff throws all that out, instead preferring the dumb memcpy()
> approach.
> 
> This needs resolving, and I'd like to see it resolved to the satisfaction
> of architecture maintainers before we progress any further down this
> route.

OK thanks, will wait until that is sorted out before merging any
of the SRAM code.

Regards,

Tony
