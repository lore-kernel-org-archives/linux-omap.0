From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 4/5] dts changes for omaps for v4.19
Date: Sat, 14 Jul 2018 14:17:44 -0700
Message-ID: <20180714211744.mbruljevib5xqmad@localhost>
References: <pull-1531314878-371161@atomide.com>
 <pull-1531314878-371161@atomide.com-4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1531314878-371161@atomide.com-4>
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

On Wed, Jul 11, 2018 at 06:19:07AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.19/dt-signed-v2
> 
> for you to fetch changes up to 792f98677d7f777a4f58e567b5b0578191cb986a:
> 
>   Merge commit '949bdcc8a97c' into omap-for-v4.19/dt (2018-07-11 05:54:32 -0700)
> 
> ----------------------------------------------------------------
> dts changes for omaps for v4.19 merge window
> 
> Mostly updates to configure and improve the devices
> found on various SoCs and boards:
> 
> - several patches to update support for am3517-evm
>   to replace bogus fixed regulators with proper
>   regulators and configure various devices such
>   as wlan, bluetooth and usb1
> 
> - add missing cooling devices for omap5 and dra7
> 
> - configure dual role for usb ports for am57xx
>   and dra7
> 
> - PM updates for omap4 devices to allow retention
>   idle for minimal configurations
> 
> - am335x-sl50 updates for various devices
> 
> - update d-can alias names to not use undescore
> 
> - configure pandaboard gpio button
> 
> - a non-urgent change to fix dcan node address that
>   i forgot to send a pull request for earlier

Merged, thanks.


-Olof
