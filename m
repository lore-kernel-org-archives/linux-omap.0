From: Joel Porquet <joel@porquet.org>
Subject: Re: [PATCH] arm:irqchip: IRQCHIP_DECLARE macro is now accessible
Date: Fri, 04 Sep 2015 16:54:21 -0400
Message-ID: <7212409.q6uiaM0l3x@joel-zenbook>
References: <1436299411-12329-1-git-send-email-joel@porquet.org>
 <20150713152035.GD26642@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150713152035.GD26642@tiger>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Monday, July 13, 2015 11:20:35 PM Shawn Guo wrote:
> On Tue, Jul 07, 2015 at 04:02:53PM -0400, Joel Porquet wrote:
> > The IRQCHIP_DECLARE macro migrated to 'include/linux/irqchip.h', making=
 it
> > globally accessible.
> > =

> > See commit 91e20b5040c67c51aad88cf87db4305c5bd7f79d
> > ("irqchip: Move IRQCHIP_DECLARE macro to include/linux/irqchip.h").
> > =

> > This patch adds inclusions of 'include/linux/irqchip.h' and replaces us=
es
> > of macro OF_DECLARE_2 with IRQCHIP_DECLARE.
> > =

> > Signed-off-by: Joel Porquet <joel@porquet.org>
> > ---
> =

> ...
> =

> >  arch/arm/mach-imx/gpc.c              | 7 ++-----
> =

> Acked-by: Shawn Guo <shawnguo@kernel.org>
> =

> How will this patch be sent to upstream?

If it's more convenient for the different maintainers affected by this patc=
h, =

I can probably resubmit it into a series of patches that modify each file =

separately... Let me know quickly so we don't miss the merge window!

Jo=EBl
