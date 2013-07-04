From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v3 2/8] wlcore: set irq_flags in the board files instead
 of hiding behind a quirk
Date: Thu, 4 Jul 2013 10:16:24 +0530
Message-ID: <51D4FE20.6000805@ti.com>
References: <1372860209-3504-1-git-send-email-coelho@ti.com>
 <1372860209-3504-3-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1372860209-3504-3-git-send-email-coelho@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Luciano Coelho <coelho@ti.com>
Cc: mark.rutland@arm.com, nm@ti.com, mturquette@linaro.org, linux-doc@vger.kernel.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, rob.herring@calxeda.com, grant.likely@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 7/3/2013 7:33 PM, Luciano Coelho wrote:
> The platform_quirk element in the platform data was used to change the
> way the IRQ is triggered.  When set, the EDGE_IRQ quirk would change
> the irqflags used and treat edge trigger differently from the rest.
> 
> Instead of hiding this irq flag setting behind the quirk, have the
> board files set the flags during initialization.  This will be more
> meaningful than driver-specific quirks when we switch to DT.
> 
> Additionally, fix missing gpio_request() calls in the boarding files
> (so that setting the flags actually works).
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Luciano Coelho <coelho@ti.com>
> ---
>  arch/arm/mach-davinci/board-da850-evm.c      |    8 +++++-

For the board-da850-evm.c change,

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
