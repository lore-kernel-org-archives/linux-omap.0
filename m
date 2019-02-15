From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 3/3] dts changes for omaps for v5.1
Date: Fri, 15 Feb 2019 14:01:16 +0100
Message-ID: <CAK8P3a1VbccFL6tSwt-HqMw=1V7H73QSgZaJbu0ME6KeyoqzSg@mail.gmail.com>
References: <pull-1548951676-587288@atomide.com>
 <pull-1548951676-587288@atomide.com-3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1548951676-587288@atomide.com-3>
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

On Thu, Jan 31, 2019 at 5:24 PM Tony Lindgren <tony@atomide.com> wrote:
> dts updates for omap variants for v5.1 merge window
>
> This series contains board specific dts updates and few minor
> clean-up changes:
>
> - add stdout-path for am335x-chiliboard
>
> - add wlcore wakeirq for omap3-evm, pandaboard and omap4-droid4
>
> - remove unnecessary address-cells and io-cells for am33xx
>
> - replace deprecated linux,wakeup with wakeup-source property
>
> - use spdx license for am335x-shc
>
> - configure ethernet pins for omap4-sdp

Pulled into arm/dt, thanks!

      Arnd
