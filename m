From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 1/3] soc changes for omaps for v5.2
Date: Sun, 28 Apr 2019 23:03:07 -0700
Message-ID: <20190429060307.5mb35baxsi5iqlcw@localhost>
References: <pull-1555087688-487222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1555087688-487222@atomide.com>
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

On Fri, Apr 12, 2019 at 10:02:05AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.2/soc-signed
> 
> for you to fetch changes up to 72aff4ecf1cb85a3c6e6b42ccbda0bc631b090b3:
> 
>   ARM: OMAP2+: pm33xx-core: Do not Turn OFF CEFUSE as PPA may be using it (2019-04-09 08:05:17 -0700)
> 
> ----------------------------------------------------------------
> SoC changes for omap variants for v5.2 merge window
> 
> This series of changes mostly consists of ti-sysc interconnect driver
> related preparation work. With these changes and the related ti-sysc
> driver changes, we can start dropping legacy omap_hwmod_*data.c platform
> data for many devices.
> 
> There are also two am335x and am437x related PM changes for secure
> devices that have ROM handling some parts and needs EFUSE power domain
> active.

Merged, thanks!


-Olof
