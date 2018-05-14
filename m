From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 3/3] omap sdhci dts changes for v4.18 merge window
Date: Mon, 14 May 2018 09:22:45 -0700
Message-ID: <20180514162245.tdsuxonucsiwyqoq@localhost>
References: <pull-1525450571-674978@atomide.com>
 <pull-1525450571-674978@atomide.com-3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1525450571-674978@atomide.com-3>
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

On Fri, May 04, 2018 at 09:17:33AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 3f4028780287ff5a7308f40e10bbba9a42b993aa:
> 
>   mmc: sdhci-omap: Get IODelay values for 3.3v DDR mode (2018-05-03 09:37:13 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.18/dt-sdhci-signed
> 
> for you to fetch changes up to 24a6f1f65ea567d017c598faf1374ee443f73851:
> 
>   Documentation: ARM: Add new MMC requirements for DRA7/K2G (2018-05-03 10:32:20 -0700)
> 
> ----------------------------------------------------------------
> Device tree changes for omap variants for SDHCI
> 
> This series adds the devicetree configuration needed for pinctrl on
> dra7 variants to use the SDHCI SDIO driver instead of mmc-omap-hs
> driver. To use SDHCI, both the pins and the iodelay needs to be
> configured.
> 
> This series is based on the related SDHCI drivers changes on a branch
> set up by Ulf.

Thanks, merged now.


-Olof
