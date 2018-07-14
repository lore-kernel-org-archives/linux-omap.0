From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] two omap fixes for v4.18-rc cycle
Date: Sat, 14 Jul 2018 15:14:39 -0700
Message-ID: <20180714221439.jz6wujv6nxb6vzon@localhost>
References: <pull-1531484945-795802@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1531484945-795802@atomide.com>
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 13, 2018 at 05:29:53AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 0144eb204cdcdf09a76794b4a294291388e739bc:
> 
>   ARM: dts: omap3: Fix am3517 mdio and emac clock references (2018-07-03 00:39:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.18/fixes-rc4-signed
> 
> for you to fetch changes up to 923847413f7316b5ced3491769b3fefa6c56a79a:
> 
>   ARM: dts: am3517.dtsi:  Disable reference to OMAP3 OTG controller (2018-07-12 06:57:05 -0700)
> 
> ----------------------------------------------------------------
> Two omap fixes for v4.18-rc cycle
> 
> Turns out the recent patches for ARM branch predictor hardening are
> not working on omap5 and dra7 as planned because the secondary CPU
> is parked to the bootrom code. We can't configure it in the bootloader.
> So we must enable invalidates of BTB for omap5 and dra7 secondary
> core in the kernel.
> 
> And there's a fix for reserved register access for am3517. The
> usb otg module on am3517 is not the same as for other omap3.

Merged, thanks!


-Olof
