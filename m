From: Lokesh Vutla <a0131933@ti.com>
Subject: Re: [PATCHv4] arm: omap2: timer: always define omap4_local_timer_init
Date: Wed, 30 Sep 2015 13:11:04 +0530
Message-ID: <560B9210.1080700@ti.com>
References: <1443543337-2904-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1443543337-2904-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Tuesday 29 September 2015 09:45 PM, Felipe Balbi wrote:
> omap4_local_timer_init() can be used by other
> platforms as is. At least AM437x wants to use
> it. Instead of making omap4-only and providing
> a stub for builds without OMAP4, we can just
> make sure that function is always available
> for all SoCs that need it.
You might also want to update init_time function pointer for AM43xx in
board_generic.c or is there any dependency for this patch? With this
patch alone AM43xx only build is broken.

arch/arm/mach-omap2/built-in.o:(.arch.info.init+0x54): undefined
reference to `omap3_gptimer_timer_init'
Makefile:944: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Thanks and regards,
Lokesh
