From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 3/3] dts changes for omaps for v4.20
Date: Fri, 28 Sep 2018 22:44:15 +0200
Message-ID: <CAK8P3a3KisdNVE=VgbBjPVJVHGacPRr2TC88JWC4DhqAJEBRmg@mail.gmail.com>
References: <pull-1537983432-167273@atomide.com>
 <pull-1537983432-167273@atomide.com-3>
 <20180927165956.1fa539de@kemnade.info> <20180927185601.GD5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180927185601.GD5662@atomide.com>
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
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, linux-omap <linux-omap@vger.kernel.org>, andreas@kemnade.info, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 27, 2018 at 8:56 PM Tony Lindgren <tony@atomide.com> wrote:

> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
>
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.20/dt-signed-v2
>
> for you to fetch changes up to 20bcd4a4d76d7474047ff4539e7d65b990bb2556:
>
>   ARM: dts: add omap3-gta04a5one to Makefile (2018-09-27 08:29:14 -0700)
>
> ----------------------------------------------------------------
> Devicetree changes for omap variants
>
> This branch contains a series of improvments for omap3-gta04 phone,
> and a series of clean-up for am335x to remove the deprecated phy_id
> property.
>
> The rest is to configure am57xx-idk boards for leds, load trigger,
> and smps, am3517-evm audio configuration, beaglebone hdmi cec support,
> coresight binding update, and fixes for i2c and spi warnings.

As discussed on IRC, I've pulled v2 now, but found a small issue with two
remaining instances of phy_id that I expect to be addressed in a follow-up.

Thanks,

       Arnd
