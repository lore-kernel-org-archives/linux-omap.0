From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/3] omap1 gpio clean-up for v4.20
Date: Fri, 28 Sep 2018 17:59:44 +0200
Message-ID: <CAK8P3a38H1Uov=YYxLD5QKBrnFEjhGvV1GJUY095RU8LuCmr8A@mail.gmail.com>
References: <pull-1537983432-167273@atomide.com>
 <pull-1537983432-167273@atomide.com-2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1537983432-167273@atomide.com-2>
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

On Wed, Sep 26, 2018 at 7:40 PM Tony Lindgren <tony@atomide.com> wrote:
>
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
>
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.20/omap1-signed
>
> for you to fetch changes up to 1137ceee76ba8b8c698e11b7150e35524f071bda:
>
>   ARM: OMAP1: ams-delta: Don't request unused GPIOs (2018-09-20 14:24:42 -0700)
>
> ----------------------------------------------------------------
> A series of omap1 gpio changes for ams-delta
>
> Janusz Krzysztofik has cleaned up ams-delta gpio usage along with
> generic gpio framework improvments. This series contains the omap1
> specific clean-up for ams-delta modem and unused gpios.
>
> Note that this conflicts with the gpio-omap changes queued into
> an immutable gpio branch ib-omap for the gpio-omap.h header file.
> The merge resolution is to drop the IS_BUILTIN(CONFIG_GPIO_OMAP)
> section and keep the #endif tagged for __ASSEMBLER__.

Pulled into next/soc, thanks!

      Arnd
