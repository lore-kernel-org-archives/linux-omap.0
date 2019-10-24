From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 3/3] drop legacy platform data for omaps for v5.5
Date: Thu, 24 Oct 2019 13:39:28 -0700
Message-ID: <CAOesGMgjG-DGjSJT4AB9D7ZQFsYorNmMyzLCHoD=UzjBLF7MvA@mail.gmail.com>
References: <pull-1571934890-285615@atomide.com>
 <pull-1571934890-285615@atomide.com-3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1571934890-285615@atomide.com-3>
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
Cc: SoC Team <soc@kernel.org>, ARM-SoC Maintainers <arm@kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 24, 2019 at 9:37 AM Tony Lindgren <tony@atomide.com> wrote:
>
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit 1819ef2e2d12d5b1a6ee54ac1c2afe35cffc677c:
>
>   bus: ti-sysc: Use swsup quirks also for am335x musb (2019-10-21 14:15:55 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.5/ti-sysc-drop-pdata-v2-signed-take2
>
> for you to fetch changes up to b08a0c577518a02ea08673f68881223a3ed35cc6:
>
>   ARM: OMAP2+: Drop legacy platform data for am335x musb (2019-10-23 07:46:32 -0700)
>
> ----------------------------------------------------------------
> Drop legacy platform data for omaps for v5.5
>
> This series of changes continues dropping legacy platform data for
> omaps. With the proper device tree configuration in place in the dts
> files for ti-sysc interconnect target module driver, we can drop the
> related platform data and legacy ti,hwmods custom property.
>
> Most of the patches in this series drop platform data and custom dts
> property one device class and one SoC at time. This way we can easily
> revert one patch at a time in case of unexpected issues if the fix is
> not trivial.
>
> For am335x musb, we need to first update the device tree to probe with
> ti-sysc interconnect target module driver. And then the following
> patches drop the legacy platform data.
>
> Note that this series depends on earlier ti-sysc related driver changes

Couldn't quite tell where to land this, but I picked arm/dt mostly to
avoid possible toplevel conflicts with other branches that touch
device trees.


Thanks!


-Olof
