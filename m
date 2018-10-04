From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] ti-sysc driver changes for omaps for v4.20
Date: Thu, 4 Oct 2018 17:19:28 +0200
Message-ID: <CAK8P3a2uKxvd5ujeemoNNuOTo_zgYth8g-PDPBfapg_1eT7_tA@mail.gmail.com>
References: <pull-1538588866-709117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1538588866-709117@atomide.com>
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

On Wed, Oct 3, 2018 at 7:48 PM Tony Lindgren <tony@atomide.com> wrote:
> TI sysc driver changes for v4.20 merge window
>
> This series gets rid of the SYSC_QUIRK_RESOURCE_PROVIDER to make device
> detection happen mostly only if #define DEBUG is set. Few core devices still
> need to be detected to set legacy quirks.
>
> We also add support for booting am335x, am437x and dra7 SoCs with L4 devices
> defined in device tree instead of legacy platform data.
>
> And finally we simplify suspend with just SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
> and dropping the custom functions that were attempting to work around
> issues that really turned out to be child device driver related issues.

Pulled into next/drivers, thanks!

> Apologies for a late pull request, debugging the suspend issues took a while
> and I did not want to send these changes until that got sorted out.

No worries.

     Arnd
