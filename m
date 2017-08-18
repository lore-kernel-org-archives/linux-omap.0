From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] device tree changes for omaps for v4.14, part2
Date: Fri, 18 Aug 2017 22:56:46 +0200
Message-ID: <CAK8P3a3pFcE79fMMX1fkj_H3=_2xORK7xKARpWTQszok43FTOg@mail.gmail.com>
References: <-4579924122609271736@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <-4579924122609271736@unknownmsgid>
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

On Thu, Aug 17, 2017 at 8:28 PM, Tony Lindgren <tony@atomide.com> wrote:
> ----------------------------------------------------------------
> Second set of device tree changes for omaps for v4.14 merge window.
> These got delayed a bit because the iodelay changes had to be
> reworked for a missing Signed-off-by. And the beagleboard-x15
> wants to use iodelay too for mmc:
>
> - A series of changes to add dra7 iodelay data used for mmc
>
> - Add support for new beagleBoard-x15 revision c
>
> - Fix logicpd-torpedo-37xx-devkit mmc card detect direction

Pulled into next/dt, thanks!

       Arnd
