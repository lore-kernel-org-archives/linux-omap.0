From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 3/3] dts changes for omaps for v4.16 merge window
Date: Thu, 21 Dec 2017 17:21:44 +0100
Message-ID: <CAK8P3a1tYb_asjD3sTZok5g_aE0m2BgTVYML8SZb9t=iku4TCw@mail.gmail.com>
References: <pull-1513266986-900907@atomide.com>
 <pull-1513266986-900907@atomide.com-3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1513266986-900907@atomide.com-3>
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

On Thu, Dec 14, 2017 at 4:58 PM, Tony Lindgren <tony@atomide.com> wrote:
> Dts related changes for omaps for v4.16 merge window
>
> These changes are mostly improvments for various devices.
> Note that these are based on my earlier fixes branch
> omap-for-v4.15/fixes-dt to avoid a pointless merge conflict
> between a fix and removal. The summary of changes is:
>
> - Fix audio codec reset pin for am335x-pepper and n900, this
>   has been always broken and won't get fixed until the related
>   driver changes are also merged in for v4.16, so not urgent
>
> - Fix tps65917 powerhold property for dra76-evm
>
> - Changes to logicpd boards to remove MTD partition information
>   and to add support for omap35xx variants by setting up common
>   dts files for the logicpd boards
>
> - Disable dra7 USB metastability workaround, this won't do
>   anything until the related driver changes are also merged
>   into v4.16, so not urgent

Pulled into next/dt, thanks!

         Arnd
