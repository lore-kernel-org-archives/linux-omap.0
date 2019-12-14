From: H. Nikolaus Schaller <hns@goldelico.com>
Subject: BUG - was: [GIT PULL 2/3] bcm2835-soc-next-2019-10-15
Date: Sat, 14 Dec 2019 11:54:19 +0100
Message-ID: <12244E4E-A1A0-4EE9-ACD3-EA165D9A2C79@goldelico.com>
References: <1571159725-5090-1-git-send-email-wahrenst@gmx.net>
 <1571159725-5090-2-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1571159725-5090-2-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux-OMAP <linux-omap@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Stefan,

> Am 15.10.2019 um 19:15 schrieb Stefan Wahren <wahrenst@gmx.net>:
> 
> Hi Florian,
> 
> The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:
> 
>  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
> 
> are available in the git repository at:
> 
>  git://github.com/anholt/linux tags/bcm2835-soc-next-2019-10-15
> 
> for you to fetch changes up to 781fa0a954240c8487683ddf837fb2c4ede8e7ca:
> 
>  ARM: bcm: Add support for BCM2711 SoC (2019-10-10 19:21:03 +0200)

this patch has finally arrived in v5.5-rc1 but it seems to break
multiplatform build.

We run a distribution kernel that supports OMAP3/4/5, i.MX6 and RasPi 3B+
but since rebasing to v5.5-rc1 the kernel hangs after "Starting Kernel ...".
On all ARM devices (incl. RasPi 3B+).

Playing with our defconfig did show that deconfiguring CONFIG_ARCH_BCM2835
makes the kernel work again.

After further analysis it turns out that reverting this patch also
makes the boards work again.

I am not exactly sure what the reason is, but it may have something to
do with the new auto-selection of CONFIG_ZONE_DMA which is not automatically
selected by OMAP and i.MX6.

To reproduce on some OMAP device (i.MX6 should be similar)

1st test:

git checkout v5.5-rc1
make omap2plus_defconfig

=> boots OMAP device

2nd test:

( echo CONFIG_ARCH_BCM2835=y; echo CONFIG_ARCH_BCM=y ) >>arch/arm/configs/omap2plus_defconfig
make omap2plus_defconfig

=> fails to boot OMAP device

3rd test:

git revert 781fa0a954240c8487683ddf837fb2c4ede8e7ca
make omap2plus_defconfig

=> boots OMAP device

BTW: the RasPi 3B+ runs equally well without this patch. So what is it
good for?

So please check and fix this patch.

> ----------------------------------------------------------------
> This pull request introduces the machine board code for the BCM2711,
> which is placed on the Raspberry Pi 4.
> 
> ----------------------------------------------------------------
> Stefan Wahren (1):
>      ARM: bcm: Add support for BCM2711 SoC
> 
> arch/arm/mach-bcm/Kconfig    |  4 +++-
> arch/arm/mach-bcm/Makefile   |  3 ++-
> arch/arm/mach-bcm/bcm2711.c  | 24 ++++++++++++++++++++++++
> arch/arm64/Kconfig.platforms |  5 +++--
> 4 files changed, 32 insertions(+), 4 deletions(-)
> create mode 100644 arch/arm/mach-bcm/bcm2711.c

BR and thanks,
Nikolaus Schaller
