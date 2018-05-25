From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 3/3] more omap dts changes for v4.18 merge window
Date: Fri, 25 May 2018 14:14:52 -0700
Message-ID: <20180525211452.bxeda6d77x5psxaz@localhost>
References: <pull-1526925630-789198@atomide.com>
 <pull-1526925630-789198@atomide.com-3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1526925630-789198@atomide.com-3>
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

On Mon, May 21, 2018 at 12:41:32PM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 8dfa75524a0e0e2b4eaf2a3dc178f6b4d8db85d9:
> 
>   ARM: dts: correct invalid I/O definition for MMC/SD card detect on T410 (2018-05-03 10:03:01 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.18/dt-part2-signed
> 
> for you to fetch changes up to 0dbf99542caf8a767ea0ac286ca8077cc5e8bd32:
> 
>   ARM: dts: am3517-evm: Add User LEDs and Pushbutton (2018-05-18 14:07:38 -0700)
> 
> ----------------------------------------------------------------
> Second set of dts changes for omap variants for v4.18 merge window
> 
> This series of changes contains fixes for already queued tps65218
> IRQ_TYPE, and fixes for omap3 and am335x use of IRQ_TYPE. There are
> also addition of oscillator clock for logicpd omap3 boards and a series
> of changes to improve support for am3517-evm board. And there is also
> a change to configure WLAN for am437x-sk-evm.

Merged, thanks!


-Olof
