From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap fixes for v4.13 merge window
Date: Thu, 27 Jul 2017 12:51:11 +0200
Message-ID: <CAK8P3a3hYEAN_hm9vc9Ae40WZPVzhg+13+5utfaSWch+u2VB4Q@mail.gmail.com>
References: <-2912443834608911586@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <-2912443834608911586@unknownmsgid>
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
Cc: linux-omap@vger.kernel.org, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 6, 2017 at 11:08 AM, Tony Lindgren <tony@atomide.com> wrote:
> The following changes since commit 1df5eaa6bced2d8a9de305d4a5f587adf57ddf35:
>
>   ARM: OMAP4: hwmod_data: add SHAM crypto accelerator (2017-06-14 00:53:51 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.13/fixes-merge-window
>
> for you to fetch changes up to ff570a01b1bd15cf8a87c9ea774fc9c52ea07f15:
>
>   ARM: dts: dra71-evm: mdio: Fix impedance values (2017-07-05 00:54:52 -0700)
>
> ----------------------------------------------------------------
> Few fixes for omaps for issues found recently:
>
> - Fix disable_irq related shared IRQ warnings for omap3 PRM
>
> - Fix omap4 legacy code regression that accidentally removed code that
>   we still need for PRM interrupts
>
> - Fix dm8168-evm NAND pins and MMC write protect pin direction
>
> - Fix dra71-evm mdio impedance values

Pulled into fixes now, thanks!

        Arnd
