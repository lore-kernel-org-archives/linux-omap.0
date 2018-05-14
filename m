From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/3] omap dts changes for v4.18 merge window
Date: Mon, 14 May 2018 01:19:42 -0700
Message-ID: <20180514081942.4j3i4h7qged62zdc@localhost>
References: <pull-1525450571-674978@atomide.com>
 <pull-1525450571-674978@atomide.com-2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1525450571-674978@atomide.com-2>
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

On Fri, May 04, 2018 at 09:17:32AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.18/dt-signed
> 
> for you to fetch changes up to 8dfa75524a0e0e2b4eaf2a3dc178f6b4d8db85d9:
> 
>   ARM: dts: correct invalid I/O definition for MMC/SD card detect on T410 (2018-05-03 10:03:01 -0700)
> 
> ----------------------------------------------------------------
> Device tree changes for omap variants for v4.18 merge window
> 
> This series adds support for am335x-pockebeagle and also add missing
> pinctrl configuration for am335x evm and beagle bone variants.
> 
> There are also changes to add missing omap3 oscillator clocks for audio,
> and fixes am437x tps65218 irq type used for various board specific
> files.
> 
> There are also few minor fixes included that are not urgent. The
> fixes for n8x0 audio also depend on driver changes, and the hp t410
> mmc card detect mux typo is harmless.

Merged, thanks!


-Olof
