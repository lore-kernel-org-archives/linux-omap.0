From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap-gpmc changes for v4.16 merge (immutable for mtd)
Date: Thu, 21 Dec 2017 16:24:18 +0100
Message-ID: <CAK8P3a1-rtV3HyiCbog20FR24oz__f4X=k=0=ND3Mk88CVd_8w@mail.gmail.com>
References: <b55511ad-6d23-0356-f2d3-8e2b7c6d1ffb@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b55511ad-6d23-0356-f2d3-8e2b7c6d1ffb@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Ladislav Michl <ladis@linux-mips.org>, Tony Lindgren <tony@atomide.com>, arm-soc <arm@kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 11, 2017 at 3:16 PM, Roger Quadros <rogerq@ti.com> wrote:
> Hi Arnd/Olof,
>
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
>
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
>
> are available in the git repository at:
>
>   https://github.com/rogerq/linux.git tags/gpmc-omap-for-v4.16-immutable
>
> for you to fetch changes up to c18a7ac3398d0cef29749f9568666db8321aa4c9:
>
>   memory: omap-gpmc: Make 'bank-width' property optional (2017-12-01 15:37:49 +0200)
>
> ----------------------------------------------------------------
> OMAP-GPMC: driver updates for v4.16
> * Error out only if both 'bank-width' and 'gpmc,device-width' DT properties are missing.

Pulled into next/drivers, thanks!

        Arnd
