From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap rcu and fiq fixes for v4.7 merge window
Date: Sat, 18 Jun 2016 22:22:27 -0700
Message-ID: <20160619052227.GC11958@localhost>
References: <20160617160754.GF22406@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160617160754.GF22406@atomide.com>
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

On Fri, Jun 17, 2016 at 09:07:54AM -0700, Tony Lindgren wrote:
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fixes-rcu-fiq-signed
> 
> for you to fetch changes up to d279f7a7e95af6bb4b5eaea3527d1f85a28c5cf6:
> 
>   ARM: dts: am437x-sk-evm: Reduce i2c0 bus speed for tps65218 (2016-06-17 02:59:04 -0700)
> 
> ----------------------------------------------------------------
> Fixes for omaps for v4.7-rc cycle:
> 
> - Two boot warning fixes from the RCU tree that should have gotten
>   merged several weeks ago already but did not because of issues
>   with who merges them. Paul has now split the RCU warning fixes into
>   sets for various maintainers.
> 
> - Fix ams-delta FIQ regression caused by omap1 sparse IRQ changes
> 
> - Fix PM for omap3 boards using timer12 and gptimer, like the
>   original beagleboard
> 
> - Fix hangs on am437x-sk-evm by lowering the I2C bus speed

Merged, thanks!


-Olof
