From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap defconfig changes for v4.17
Date: Tue, 27 Mar 2018 15:20:19 +0200
Message-ID: <CAK8P3a1nN0-gPWj-XiLHCeTqnAP2BGFmgZjUjyW=1O0FYQ_z6Q@mail.gmail.com>
References: <pull-1521214671-54392@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1521214671-54392@atomide.com>
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
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 16, 2018 at 4:38 PM, Tony Lindgren <tony@atomide.com> wrote:

> Defconfig updates for omap variants for v4.17 merge window
>
> We need to enable MMC_SDHCI option in both omap2plus_defconfig and
> multi_v7_defconfig so systems are able to mount root when the dts files
> get updated for sdhci.
>
> Then let's update omap2plus_defconfig so we can patch it easier. And as
> Arnd noticed earlier, just running make savedefconfig will accidentally
> drop few Kconfig options. This is happening because some options are no
> longer available as loadable modules like LIRC. Or new dependencies have
> been added such as SND_OSSEMUL for selecting SOUND_OSS_CORE.
>
> So we first move the unchanged options around to their make savedefconfig
> suggested place, then update the options to prevent make savedefconfig
> dropping some options accidentally, and then finally drop the unused
> options.
>
> And after that we enable options DRM_OMAP and 8250_OMAP. These both have
> been around for years now. And we do have 8250_OMAP warn about console
> being redirected with SERIAL_8250_OMAP_TTYO_FIXUP option that is enabled
> by default. Some users may need to update their inittab to use ttyS*
> instead of ttyO* though. If this turns out to be a problem, we may want
> to introduce a separate compatible for 8250-omap. But I think we're good
> to go with the SERIAL_8250_OMAP_TTYO_FIXUP warning now. Let's not update
> multi_v7_defconfig yet though and first see how 8250_OMAP change plays
> out.
>
> We also enable few new options for PM on am335x and am437x, and CEC in
> omap2plus_defconfig. Naturally similar options can be later on added to
> multi_v7_defconfig, but in this series we only enable OTG, MUSB and the
> related PHYs in multi_v7_defconfig to make it more usable for distros.

Pulled into next/soc. I got a small conflct that I resolved, and checked
that the resulting defconfig is identical to the one produced by savedefconfig
again.

      Arnd
