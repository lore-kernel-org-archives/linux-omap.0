From: Tony Lindgren <tony@atomide.com>
Subject: Re: [CFT] Always enable SMP mode on MP capable CPUs
Date: Wed, 24 May 2017 08:38:47 -0700
Message-ID: <20170524153847.GY10472@atomide.com>
References: <20170518105209.GN22219@n2100.armlinux.org.uk>
 <CAOMZO5Da2R2_t2nU+MdrJiSzvcBQKS4pwYS96r4UyfGc8DtWww@mail.gmail.com>
 <CAOMZO5Dc=i7UdQH=r5RRr_4GmyZZT+rh7BTNV4WbfqKvtVDfsw@mail.gmail.com>
 <20170519171526.GW22219@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170519171526.GW22219@n2100.armlinux.org.uk>
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
Cc: linux-omap@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [170519 10:19]:
> On Fri, May 19, 2017 at 02:07:28PM -0300, Fabio Estevam wrote:
> > On Thu, May 18, 2017 at 3:09 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > 
> > > I tested this patch on a mx6ul, which is CortexA7 UP using USB serial
> > > download mode.
> > >
> > > In this boot mode the ROM code does not set the SMP bit and I can
> > > notice a very slow boot progress with CONFIG_SMP=n with an original
> > > 4.12-rc1.
> > >
> > > With this patch applied it boots with the correct speed, so:
> > 
> > However the kernel still takes a long time to decompress when the
> > bootloader or ROM does not set the SMP bit.
> > 
> > After it decompress, then it boots quickly.
> > 
> > Should the SMP bit be set inside arch/arm/boot/compressed/head.S?
> 
> We could expand the table to positively identify the SMP capable CPUs
> and enable the SMP bit there, but it's going to add a lot of entries
> there (one for each specific ARMv7 MP CPU) and is going to have to be
> endlessly added to each time a new SMP CPU comes out.

Looks like commit e414690faa81 ("ARM: always enable SMP mode on SMP cores")
causes booting to fail early at least on omap4430 duovero. It's a bit of
a mystery as it is SMP.. And pandboard es (4460) and droid 4 (4430) work
without the conditional write..

Partial revert like below seems to make it boot again.

Regards,

Tony

8< -------------------
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 4d48a4cf563b..ad653ec0835e 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -289,7 +289,8 @@ __v7_ca17mp_setup:
 	mrc	p15, 0, r0, c1, c0, 1
 	orr	r10, r10, #(1 << 6)		@ Enable SMP/nAMP mode
 	orr	r10, r10, r0			@ Set required bits
-	mcr	p15, 0, r10, c1, c0, 1		@ No, update register
+	teq	r10, r0				@ Were they already set?
+	mcrne	p15, 0, r10, c1, c0, 1		@ No, update register
 	b	__v7_setup_cont
 
 /*
