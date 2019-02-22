From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] dts changes for cpsw phy driver for v5.1
Date: Fri, 22 Feb 2019 14:55:37 +0100
Message-ID: <CAK8P3a2vEGLiQZNzWOt17dZj=9-vutsNzVcH3cd82Qc2yC=HLw@mail.gmail.com>
References: <pull-1550767488-25979@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1550767488-25979@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 21, 2019 at 5:45 PM Tony Lindgren <tony@atomide.com> wrote:
>
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit 947b7802597106dcbef2ddca23d386f9339ba334:
>
>   ARM: dts: omap3-gta04: declare backlight in lcd node (2019-02-12 10:52:25 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/dt-cpsw-phy
>
> for you to fetch changes up to bae2bf97939aebd74dfd8f0b76b4902a19e63eef:
>
>   dt-bindings: net: ti: deprecate cpsw-phy-sel bindings (2019-02-20 08:14:04 -0800)
>
> ----------------------------------------------------------------
> Device tree changes to make CPSW Ethernet use proper phy driver
>
> We now have a proper PHY driver with drivers/phy/ti/phy-gmii-sel.c to
> configure the CPSW PHY. These changes update all CPSW users to use the
> new driver that already got merged during v5.0 merge window.

Pulled into arm/dt, thanks!

     Arnd
