From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] dts driver fixes for omaps for v4.16 merge window
Date: Mon, 22 Jan 2018 12:37:46 +0100
Message-ID: <CAK8P3a2jjpo0R8iQPd+HP-e20Pe2BC9pBbWsoTpXVDanKfffNQ@mail.gmail.com>
References: <pull-1516376193-270253@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1516376193-270253@atomide.com>
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

On Fri, Jan 19, 2018 at 4:38 PM, Tony Lindgren <tony@atomide.com> wrote:
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit 80a06c0d8357d1e75a8fbc10813fcdada4d897fb:
>
>   ARM: dts: dm816x: add clkctrl nodes (2017-12-11 08:28:37 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/dt-clk-dts-signed
>
> for you to fetch changes up to e14d7e5320ebae9bffe4fbd585dfdd9d6de2550f:
>
>   ARM: dts: Update ti-sysc data for existing users (2018-01-12 15:16:57 -0800)
>
> ----------------------------------------------------------------
> Few omap interconnect dts fixes for v4.16 merge window
>
> Now that we have the dts clocks for the clkctrl clock and the
> interconnect binding, we need to update the existing ti-sysc
> users according to the binding to make it usable for drivers.
>
> Apologies for not being able to send this earlier but it took
> me few revisions to get the smartreflex changes right and
> tested with yet to be posted patches to make smartreflex probe
> with dts and I wanted to have it sit in next for a while to make
> sure we're not introducing regressions for legacy platform data
> based booting.
>
> Note that this is based on a merge with commit 20a2742e5784
> ("dt-bindings: ti-sysc: Update binding for timers and capabilities")
> to avoid a merge conflict with the binding changes.

Pulled into next/dt, thanks!

       Arnd
