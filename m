From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/5] ARM: OMAP2+: add includes for missing prototypes
Date: Tue, 13 Mar 2012 12:23:14 +0530
Message-ID: <CAMQu2gytxATib1HzKNL65jgaNvQ_vf-isKL_RiKDO7ef75u-hA@mail.gmail.com>
References: <20120312224006.4103.29464.stgit@dusk>
 <20120312224252.4103.75837.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120312224252.4103.75837.stgit@dusk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 13, 2012 at 4:12 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Several C files in arch/arm/mach-omap2 declare functions that are used
> by other files, but don't include the header file where the prototype is
> declared. =A0This results in the following warnings from sparse:
>
> =A0 =A0arch/arm/mach-omap2/irq.c:114:5: warning: symbol 'omap_irq_pending=
' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/irq.c:186:13: warning: symbol 'omap2_init_irq'=
 was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/irq.c:191:13: warning: symbol 'omap3_init_irq'=
 was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/irq.c:196:13: warning: symbol 'ti81xx_init_irq=
' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/irq.c:233:39: warning: symbol 'omap2_intc_hand=
le_irq' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/irq.c:242:6: warning: symbol 'omap_intc_save_c=
ontext' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/irq.c:265:6: warning: symbol 'omap_intc_restor=
e_context' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/irq.c:291:6: warning: symbol 'omap3_intc_suspe=
nd' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/irq.c:297:6: warning: symbol 'omap3_intc_prepa=
re_idle' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/irq.c:306:6: warning: symbol 'omap3_intc_resum=
e_idle' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/irq.c:312:39: warning: symbol 'omap3_intc_hand=
le_irq' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/omap-secure.c:59:12: warning: symbol 'omap_sec=
ure_ram_reserve_memblock' was not declared. Should it be static?
> =A0 =A0arch/arm/mach-omap2/board-zoom-display.c:133:13: warning: symbol '=
zoom_display_init' was not declared. Should it be static?
>
> Fix by including the appropriate header files.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Senthilvadivu Guruswamy <svadivu@ti.com>
> ---
Thanks Paul for the fix.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
