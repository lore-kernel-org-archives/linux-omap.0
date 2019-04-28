From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 1/2] device tree changes for omaps for v5.2
Date: Sun, 28 Apr 2019 12:32:49 -0700
Message-ID: <20190428193249.uufhjnvkuzxhh6xp@localhost>
References: <pull-1555343712-332506@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1555343712-332506@atomide.com>
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

On Mon, Apr 15, 2019 at 10:00:53AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.2/dt-signed
> 
> for you to fetch changes up to bcbb63b80284af0061ac44fe944d31a8482d2b8a:
> 
>   ARM: dts: dra7: Separate AM57 dtsi files (2019-04-12 09:57:07 -0700)
> 
> ----------------------------------------------------------------
> Devicetree changes for omap variants
> 
> This series of changes configures dra7 pcie x2 lane mode, configures
> am43xx-epos-evm regulators and keypad wakeup source, and uses standard
> reset-gpios instead of gpio-reset for n810.
> 
> We also need to split dra7 dtsi files for properly supporting dra76x
> and am576 as some of the devices are different such as usb and pruss.

Merged, thanks!


-Olof
