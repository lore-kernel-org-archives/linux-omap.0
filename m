From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 3/4] drop more legacy pdata for omaps for v5.4
Date: Wed, 4 Sep 2019 17:27:15 +0200
Message-ID: <CAK8P3a1C_OEPwrf-vdEmns5f87GN6dtsoda_WVmZAxEvLfFiDw@mail.gmail.com>
References: <pull-1567016893-318461@atomide.com>
 <pull-1567016893-318461@atomide.com-3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1567016893-318461@atomide.com-3>
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
Cc: SoC Team <soc@kernel.org>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 28, 2019 at 8:35 PM Tony Lindgren <tony@atomide.com> wrote:
> Drop legacy platform data omap variants for v5.4
>
> We can now drop more platform data in favor of dts data for most
> devices like cpsw, gpio, i2c, mmc, uart and watchdog.
>
> In general we can do this by dropping legacy "ti,hwmods" custom dts
> property, and the platform data assuming the related dts data is correct.
> This is best done as single patch as otherwise we'd have to revert two
> patches in case of any unexpected issues, and we're just removing data.
>
> Fro cpsw, before we can do this, we need to configure the cpsw mdio clocks
> properly in dts though in the first patch. For omap4 i2c, we've already
> dropped the platform data earlier, but have been still allocting it
> dynamically based on the dts data based on the "ti,hwmods" property, but
> that is no longer needed. For d2d, we are missing the dts data, so we
> first add it and then drop the platform data.
>
> For dra7, we drop platform data and "ti,hwmods" for mcasp and mcspi.
> We've already dropped platform data earlier for gpio, i2c, mmc, and
> uart so we just need to drop "ti,hwmods" property for those.
>
> Note that this branch is based on earlier ti-sysc-fixes branch.

Pulled into arm/late, thanks!

     Arnd
