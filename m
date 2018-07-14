From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 5/5] dts changes for omap mcan for v4.19
Date: Sat, 14 Jul 2018 14:19:25 -0700
Message-ID: <20180714211925.btxeb3ewlohndsiz@localhost>
References: <pull-1531314878-371161@atomide.com>
 <pull-1531314878-371161@atomide.com-5>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1531314878-371161@atomide.com-5>
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

On Wed, Jul 11, 2018 at 06:19:08AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 596e7955692b5d8b042fca500b7a83c25dfcf936:
> 
>   bus: ti-sysc: Add support for software reset (2018-07-09 22:31:38 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.19/dt-mcan-v2-signed-v2
> 
> for you to fetch changes up to 0adbe832f21ac8478f33aa64627c92fd3225b944:
> 
>   ARM: dts: dra76x: Add MCAN node (2018-07-10 04:05:30 -0700)
> 
> ----------------------------------------------------------------
> dts changes for mcan for omaps for v4.19 merge window
> 
> These changes configure the mcan clock, interconnect target
> module and mcan device. These changes depend on the ti-sysc
> related driver changes and are based on those.
> 
> Notably this is the first new driver that probes with ti-sysc
> driver with no legacy hwmod platform data for the interconnect
> target module.

Hi Tony,

I'm not entirely sure why you sent this as a separate pull request, but it also
conflicts with your first DT branch (add/add conflict at the end of the file).

Fixed up by keeping both sides, merged.


-Olof
