From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 1/5] omap1 soc changes for v4.19
Date: Sat, 14 Jul 2018 14:44:49 -0700
Message-ID: <20180714214449.7mcqfijllh2z564q@localhost>
References: <pull-1531314878-371161@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1531314878-371161@atomide.com>
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 11, 2018 at 06:19:04AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.19/omap1-v2-signed
> 
> for you to fetch changes up to d08605a64e67944eaecfb0e6340f633e01376951:
> 
>   ARM: OMAP1: ams-delta: move late devices back to init_machine (2018-07-02 23:07:54 -0700)
> 
> ----------------------------------------------------------------
> SoC updates for omap1 for v4.19 merge window
> 
> Mostly a series by Janusz Krzysztofik to clean up the
> GPIO and input handling for ams-delta. Because of the
> platform data changes, we decided that it's best to
> merge the related input changes also via the arm-soc
> tree so Dmitry Torokhov has acked the input changes.
> 
> Also included is a change to constify gpio_leds from
> Arvind Yadav.

Great, thanks for the heads up on the acks. Merged!


-Olof
