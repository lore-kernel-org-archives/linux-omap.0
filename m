From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] fixes for omaps for v4.14-rc cycle
Date: Tue, 3 Oct 2017 18:16:11 -0700
Message-ID: <20171004011611.5fl7uzzma6r3klvk@localhost>
References: <pull-1506976058-232051@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1506976058-232051@atomide.com>
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

On Mon, Oct 02, 2017 at 01:28:05PM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:
> 
>   Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.14/fixes-rc3
> 
> for you to fetch changes up to 4afa616ce937f88d9a69a71b8c561551596a81e3:
> 
>   ARM: dts: am43xx-epos-evm: Remove extra CPSW EMAC entry (2017-09-19 10:59:26 -0700)
> 
> ----------------------------------------------------------------
> Fixes for omaps for v4.14-rc cycle
> 
> Few minor fixes for omaps, mostly just boot time warning fixes:
> 
> - Drop undocumented camera binding that got merged during the merge window by
>   accident as I applied before Sakari's comments
> 
> - Fix soft reset warning for dra7 kexec boot for gpio1 as the optional clocks
>   need to be enabled for reset
> 
> - Fix dra7 kexec boot clock rate for McASP as the rate is no longer the default
>   rate after kexec
> 
> - Fix omap3 pandora MMC warning during boot
> 
> - Add am33xx SPI alias like we have on other SoCs
> 
> - Remove node for non-existing CPSW EMAC Ethernet on am43xx-epos-evm

Merged, thanks.


-Olof
