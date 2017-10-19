From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 1/2] soc changes for omaps for v4.15 merge window
Date: Thu, 19 Oct 2017 22:46:12 +0200
Message-ID: <CAK8P3a0gfs2GQVKEiiSAHgJSBywi5CNeNHHz=jcyM+fbp6LHvA@mail.gmail.com>
References: <pull-1507912705-793554@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1507912705-793554@atomide.com>
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

On Fri, Oct 13, 2017 at 6:39 PM, Tony Lindgren <tony@atomide.com> wrote:
> SoC changes for omaps for v4.15 merge window that are mostly non-urgent
> fixes and clean-up in preparation for dropping more platform data later
> on:
>
> - Fix am33xx/am437x MMC address space offsets
>
> - Fix overwriting clkctrl and modulemode values when dts data is
>   used
>
> - Drop unused platform init code for omap_init_hdq
>
> - Drop unused struct omap_hwmod_mux_info
>
> - Remove duplicate define for dra722 es1.0 silicon revision
>
> - Add support for dra71x es2.1
>
> - Make omap_dma_dev_info __initdata
>
> - A series of fixes for Coccinelle found issues

Pulled into next/soc, thanks!

       Arnd
