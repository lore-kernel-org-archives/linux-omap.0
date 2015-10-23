From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap dts changes for v4.4 merge window, part 2
Date: Fri, 23 Oct 2015 22:19:25 +0200
Message-ID: <4174355.uUodgcne1B@wuerfel>
References: <20151020193501.GN3078@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151020193501.GN3078@atomide.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 20 October 2015 12:35:02 Tony Lindgren wrote:
> Few more omap dts changes for v4.4 merge window, mostly to fix and clean
> up some omap5 issues to allow adding other omap5 boards. Also some other
> fixes and clean-up:
> 
> - Fix SDIO WLAN for omap5 that's been broken for a while. As further
>   patches are still needed for wl18xx, no need for stable on this one.
> 
> - Move most of omap5 support into omap5-board-common.dtsi as most omap5
>   boards seem to share the same basic set of devices.
> 
> - Add minimal IGEPv5 support using based on omap5-board-common.dtsi
> 
> - Remove now unneedes gpio hogging for dra72-evm
> 
> - Update Javier Martinez Canillas email address
> 
> - Change earlier IGEP boards to use IOPAD pinmux macros
> 

Pulled into next/dt, thanks!

	Arnd
