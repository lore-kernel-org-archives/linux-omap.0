From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH] ARM: OMAP2: reboot: Include common.h to fix build error
Date: Thu, 20 Jun 2013 05:59:02 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EB22C4C@DBDE04.ent.ti.com>
References: <1371664001.9848.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1371664001.9848.1.camel@phoenix>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Axel Lin <axel.lin@ingics.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Robin Holt <holt@sgi.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Jun 19, 2013 at 23:16:41, Axel Lin wrote:

> Include common.h which will include linux/reboot.h to fix below build error.
> 
>   CC      arch/arm/mach-omap2/omap4-restart.o
> arch/arm/mach-omap2/omap4-restart.c:21:28: warning: 'enum reboot_mode' declared inside parameter list [enabled by default]
> arch/arm/mach-omap2/omap4-restart.c:21:28: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
> arch/arm/mach-omap2/omap4-restart.c:21:40: error: parameter 1 ('mode') has incomplete type
> arch/arm/mach-omap2/omap4-restart.c:21:6: warning: function declaration isn't a prototype [-Wstrict-prototypes]
> make[1]: *** [arch/arm/mach-omap2/omap4-restart.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Seems this build error is introduced by commit 7507d035f3cf40c
> "reboot: arm: change reboot_mode to use enum reboot_mode"
> 
> This patch is against linux-next 20130619.

> diff --git a/arch/arm/mach-omap2/omap4-restart.c b/arch/arm/mach-omap2/omap4-restart.c
> index 652adde..7306d9b 100644
> --- a/arch/arm/mach-omap2/omap4-restart.c
> +++ b/arch/arm/mach-omap2/omap4-restart.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/types.h>
>  #include "prminst44xx.h"
> +#include "common.h"

Arnd has posted a patch [1] that includes reboot.h directly for
multiple platforms including this one.

Regards
Afzal

[1] https://lkml.org/lkml/2013/6/19/498
