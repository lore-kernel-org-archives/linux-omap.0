From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] two omap fixes for v4.3-rc cycle
Date: Wed, 21 Oct 2015 17:02:20 +0200
Message-ID: <4037170.1cl4xHYRla@wuerfel>
References: <20151020193401.GM3078@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151020193401.GM3078@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 20 October 2015 12:34:01 Tony Lindgren wrote:
> The following changes since commit d8e1f5ed11a39a68da00f05000466c4f6db4456e:
> 
>   Documentation: ARM: List new omap MMC requirements (2015-10-12 16:23:34 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/fixes-rc6
> 
> for you to fetch changes up to 57df5380853460bc66b59a46273ce113c923d39c:
> 
>   ARM: OMAP2+: Fix imprecise external abort caused by bogus SRAM init (2015-10-19 08:55:46 -0700)
> 
> ----------------------------------------------------------------
> Fixes for omaps for v4.3-rc cycle:
> 
> - Fix oops with LPAE and moew than 2GB of memory by enabling
>   ZONE_DMA for LPAE. Probably no need for stable on this one as we
>   only recently ran into this with the mainline kernel
> 
> - Fix imprecise external abort caused by bogus SRAM init. This affects
>   dm814x recently merged, so no need for stable on this one AFAIK

Applied to fixes, thanks!

	Arnd
