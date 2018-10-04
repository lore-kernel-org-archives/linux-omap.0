From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] more dts changes for omaps for v4.20
Date: Thu, 4 Oct 2018 16:13:55 +0200
Message-ID: <CAK8P3a37xraYEXZs8bQDD76NpsdcajCeZQAonWqbf6Vu5mLiEw@mail.gmail.com>
References: <pull-1538491958-348872@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1538491958-348872@atomide.com>
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

On Tue, Oct 2, 2018 at 4:53 PM Tony Lindgren <tony@atomide.com> wrote:
> More devicetree changes for omap variants
>
> There's a patch for previously merged dts changes to remove the last
> remaining use of legacy phy_id property.
>
> For dra7, we have a non-urgent PCIe dts fix, enable a PCIe errata for
> unaligned access.
>
> For omap5, we enable omap5 USB OTG mode for DWC3 controller.
>
> And we add support for am335x based Moxa UC-2100 series of industrial
> computers.

Pulled into next/dt, thanks!

      Arnd
