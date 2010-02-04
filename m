From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/5] OMAP4: Add L2 Cache support
Date: Thu, 4 Feb 2010 14:41:16 +0000
Message-ID: <20100204144116.GA27344@n2100.arm.linux.org.uk>
References: <1265293547-18960-1-git-send-email-santosh.shilimkar@ti.com>
	<1265293547-18960-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1265293547-18960-2-git-send-email-santosh.shilimkar@ti.com>
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
Cc: tony@atomide.com, catalin.marinas@arm.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 04, 2010 at 07:55:44PM +0530, Santosh Shilimkar wrote:
> This patch adds L2 Cache support for OMAP4. External L2 cache
> is used in OMPA4

OMAP4.

> @@ -49,6 +50,58 @@ static struct omap_lcd_config sdp4430_lcd_config __initdata = {
>  static struct omap_board_config_kernel sdp4430_config[] __initdata = {
>  	{ OMAP_TAG_LCD,		&sdp4430_lcd_config },
>  };

Blank line here.
