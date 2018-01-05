From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/4] driver changes for ti-sysc for v4.16
Date: Thu, 4 Jan 2018 23:06:17 -0800
Message-ID: <20180105070617.lwpwh42ujdkjao22@localhost>
References: <pull-1513966338-859035@atomide.com>
 <pull-1513966338-859035@atomide.com-2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1513966338-859035@atomide.com-2>
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

On Fri, Dec 22, 2017 at 10:14:25AM -0800, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
> 
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/ti-sysc-signed
> 
> for you to fetch changes up to c5a2de97fbd2979fab291fb048084d3fddd322dd:
> 
>   bus: ti-sysc: Add parsing of module capabilities (2017-12-21 07:28:54 -0800)
> 
> ----------------------------------------------------------------
> TI sysc driver updates for v4.16 merge window
> 
> We now have gotten ti-sysc driver to the point where it can parse
> interconnect target configuration from device tree instead of the
> legacy platform data. This series updates the device tree binding
> and adds parsing to the driver for quirks and capabilities.
> 
> ----------------------------------------------------------------
> Tony Lindgren (8):
>       dt-bindings: ti-sysc: Update binding for timers and capabilities
>       ARM: dts: Add generic ti,sysc compatible in addition to the custom ones
>       ARM: OMAP2+: Move all omap_hwmod_sysc_fields to omap_hwmod_common_data.c
>       bus: ti-sysc: Make omap_hwmod_sysc_fields into sysc_regbits platform data
>       bus: ti-sysc: Add register bits for interconnect target modules
>       bus: ti-sysc: Detect i2c interconnect target module based on register layout
>       bus: ti-sysc: Handle module quirks based dts configuration
>       bus: ti-sysc: Add parsing of module capabilities

Merged, thanks.


-Olof
