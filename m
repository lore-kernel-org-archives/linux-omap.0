From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 2/3] ti-sysc driver changes for omaps for v5.2
Date: Sun, 28 Apr 2019 23:03:53 -0700
Message-ID: <20190429060353.45vk2anagak44z3o@localhost>
References: <pull-1555087688-487222@atomide.com>
 <pull-1555087688-487222@atomide.com-2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1555087688-487222@atomide.com-2>
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

On Fri, Apr 12, 2019 at 10:02:06AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 8b30919a4e3c7aba32dd72e8208147a6496cb16c:
> 
>   ARM: OMAP2+: Handle reset quirks for dynamically allocated modules (2019-03-26 11:26:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.2/ti-sysc-signed
> 
> for you to fetch changes up to d59b60564cbfe77d85c2f51b29941d8ed14984d1:
> 
>   bus: ti-sysc: Add generic enable/disable functions (2019-04-09 08:58:48 -0700)
> 
> ----------------------------------------------------------------
> Driver changes for ti-sysc for v5.2 merge window
> 
> This series of changes for ti-sysc interconnect target module driver
> gets us to the point where we can actually drop legacy platform data
> for many devices in favor of device tree data.
> 
> To do this, we improve ti-sysc driver not to rely on platform data
> callbacks to manage module clocks, and handle more quirks needed for
> some devices. Also few minor fixes are needed, but were considered
> not needed to be sent separately as they only show up with this series.
> 
> Then we drop several thousands of lines of legacy platform data for
> omap4, omap5, dra7, am335x and am437x. We drop platform data for mmc,
> i2c, gpio and uart devices to start with as those are typically
> easily tested on all devices. In case of unexpected issues, we can just
> add back the legacy platform data for a single device type if needed.
> 
> Finally we add initial support for enabling and disabling some devices
> without legacy platform data callbacks. I was planning on sending the
> dropping of legacy platform data as a separate series, but already
> applied Roger's patch on top and pushed it out.
> 
> Note that this series depends on related SoC and is based on those.

Nice cleanup!

Merged, thanks!


-Olof
