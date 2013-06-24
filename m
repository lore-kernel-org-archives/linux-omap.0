From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [GIT PULL] DaVinci SoC updates for v3.11 (part 2)
Date: Mon, 24 Jun 2013 20:16:21 +0530
Message-ID: <51C85BBD.1080002@ti.com>
References: <51C85ABE.6020505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <51C85ABE.6020505-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

replying to own with address of DaVinci kernel list fixed.

On 6/24/2013 8:12 PM, Sekhar Nori wrote:
> Hi Arnd, Olof,
> 
> Can you please pull the following EDMA related updates for v3.11?
> There is a small change to drivers/dma/Kconfig that would have liked 
> Vinod's ack, but the change is pretty trivial and the patches have
> been out there for pretty long now.
> 
> Thanks,
> Sekhar
> 
> The following changes since commit 7bb5d75ce91ca3725256c0d502624ed697231cde:
> 
>   ARM: edma: remove unused transfer controller handlers (2013-06-18 10:53:13 +0530)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.11/soc-2
> 
> for you to fetch changes up to e65abbbc5279319ab679298f8740ddf53e022a5e:
> 
>   dmaengine: edma: enable build for AM33XX (2013-06-24 15:55:08 +0530)
> 
> ----------------------------------------------------------------
> DaVinci SoC updates for v3.11 - part 2
> --------------------------------------
> 
> This pull request adds DT and runtime PM to
> EDMA ARM private API so it can be used on
> DT enabled DaVinci and OMAP platforms.
> 
> Also adds DMA channel crossbar mapping
> support to be used by DT-enabled platforms
> which use it.
> 
> ----------------------------------------------------------------
> Lad, Prabhakar (1):
>       ARM: edma: Convert to devm_* api
> 
> Matt Porter (4):
>       dmaengine: edma: Add TI EDMA device tree binding
>       ARM: edma: Add DT and runtime PM support to the private EDMA API
>       ARM: edma: Add EDMA crossbar event mux support
>       dmaengine: edma: enable build for AM33XX
> 
>  Documentation/devicetree/bindings/dma/ti-edma.txt |   34 +++
>  arch/arm/common/edma.c                            |  329 +++++++++++++++++----
>  arch/arm/mach-davinci/devices-da8xx.c             |    8 +-
>  arch/arm/mach-davinci/devices-tnetv107x.c         |    4 +-
>  arch/arm/mach-davinci/dm355.c                     |    4 +-
>  arch/arm/mach-davinci/dm365.c                     |    4 +-
>  arch/arm/mach-davinci/dm644x.c                    |    4 +-
>  arch/arm/mach-davinci/dm646x.c                    |    4 +-
>  arch/arm/mach-omap2/Kconfig                       |    1 +
>  drivers/dma/Kconfig                               |    2 +-
>  include/linux/platform_data/edma.h                |    5 +-
>  11 files changed, 324 insertions(+), 75 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt
> 
