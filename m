From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap-gpmc changes for v4.9 merge window
Date: Fri, 02 Sep 2016 18:28:24 +0200
Message-ID: <64181757.1UAW2kMoRa@wuerfel>
References: <16b618d9-735f-f20c-7966-6e3d23b6b44e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <16b618d9-735f-f20c-7966-6e3d23b6b44e@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, arm@kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Monday, August 29, 2016 11:30:34 AM CEST Roger Quadros wrote:
> OMAP-GPMC: driver updates for v4.9
> 
> * Fix potential build failure if CONFIG_OMAP_GPMC is disabled while
>   OMAP_NAND driver is enabled
> * Trivial fixes which fix build warnings and code check tool warnings
>   (Coccinelle)
> * Use devm_gpiochip_add_data()
> 

Pulled into next/drivers, thanks!

	Arnd
