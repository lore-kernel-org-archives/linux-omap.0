From: Roger Quadros <rogerq@ti.com>
Subject: Re: [GIT PULL] omap-gpmc fixes for v4.8-rc1
Date: Wed, 24 Aug 2016 11:38:24 +0300
Message-ID: <68e0e835-4679-f950-0a2f-65e221e11ffb@ti.com>
References: <a4bd1d47-87b1-9ef9-d9d1-6c69be404b9e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <a4bd1d47-87b1-9ef9-d9d1-6c69be404b9e@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Johan Hovold <johan@kernel.org>, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Arnd/Olof,

On 15/08/16 10:53, Roger Quadros wrote:
> Hi Arnd/Olof,
> 
> The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:
> 
>   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/rogerq/linux.git tags/gpmc-omap-v4.8-rc1
> 
> for you to fetch changes up to 23540d6e2f3193b946c4de43e3f9654fa6d23fe7:
> 
>   memory: omap-gpmc: allow probe of child nodes to fail (2016-08-08 11:18:40 +0300)
> 
> ----------------------------------------------------------------
> OMAP-GPMC: fixes for v4.8-rc1
> 
> * Allow other children of GPMC to probe even if any child fails.
> This fixes problem on Overo boards where networking device child
> doesn't probe due to broken NAND child.
> 
> ----------------------------------------------------------------

Gentle reminder to pick this for v4.8-rc. Thanks.

cheers,
-roger


> Johan Hovold (1):
>       memory: omap-gpmc: allow probe of child nodes to fail
> 
>  drivers/memory/omap-gpmc.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
