From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 4/4] device tree changes for omaps for v4.14
Date: Wed, 16 Aug 2017 23:28:24 +0200
Message-ID: <CAK8P3a1EuWq4pS_JTEcrKbQKZLpUncLE5d226Z-xnyauLTWcqA@mail.gmail.com>
References: <5246773866334625482@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5246773866334625482@unknownmsgid>
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

On Tue, Aug 15, 2017 at 6:52 PM, Tony Lindgren <tony@atomide.com> wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> ----------------------------------------------------------------
> Device tree changes for omaps for v4.14 merge window:
>
> - A series of changes for dra7 and am572 to use generic
>   MMC vqmmc regulator
>
> - Clean-up tps65217 internal interrupts to define them
>   only in tps65217.dtsi
>
> - Add dra7 iodelay pinctrl driver configuration
>
> - Add buzzer support for am437x-gp-evm
>
> - Disable HDMI CEC internal pull-ups as it seems that
>   all boards have an external pull for these
>
> - Remove unnecessary interrupt-parent for omap3
>
> - Configure droid 4 vaudio regulator initial mode and
>   add vibrator
>
> - Enable NAND dma prefetch for am335x-evm, am437x and dra7
>
> - Add pcie1 dt node for EP mode for am57x and dra7
>
> - Add support for new dra76x SoCs and dra76x-evm

Pulled into next/dt, thanks!

    Arnd
