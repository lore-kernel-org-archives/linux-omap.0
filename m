From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 14/16] omap: mux: Mux 2430 USB0HS_STP in board-2430.c
Date: Wed, 30 Jun 2010 15:28:11 +0300
Message-ID: <20100630122811.GR3843@nokia.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
	<20100630120723.2637.54397.stgit@baageli.muru.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20100630120723.2637.54397.stgit@baageli.muru.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

hi,

On Wed, Jun 30, 2010 at 02:07:23PM +0200, ext Tony Lindgren wrote:
>diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
>index e06d65e..5f04d3f 100644
>--- a/drivers/usb/musb/omap2430.c
>+++ b/drivers/usb/musb/omap2430.c
>@@ -194,10 +194,6 @@ int __init musb_platform_init(struct musb *musb, void *board_data)
> 	u32 l;
> 	struct omap_musb_board_data *data = board_data;
>
>-#if defined(CONFIG_ARCH_OMAP2430)
>-	omap_cfg_reg(AE5_2430_USB0HS_STP);
>-#endif

there's a patch from Anand taking care of this hunk, could you send only 
the hunk on board-2430sdp.c ?

this part on omap2430.c will go on next merge window.

-- 
balbi

DefectiveByDesign.org
