From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH 0/5] Change omap DEBUG_LL code to use inituart for
	AUTO_ZRELADDR and ARM_PATCH_PHYS_VIRT
Date: Wed, 9 Feb 2011 11:38:56 +0530
Message-ID: <AANLkTik_22C6Uq1tLHowq0drf6h82XbeXF2ggzoaQbqU@mail.gmail.com>
References: <20110204012317.26410.55157.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110204012317.26410.55157.stgit@baageli.muru.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 4, 2011 at 6:56 AM, Tony Lindgren <tony@atomide.com> wrote:
> Here are the changes to make omap DEBUG_LL code generic using
> the new inituart macro posted in a separate series. This allows
> leaving out the dependency to the uncompress code and allows
> error messages when trying to boot a wrong zImage.
>
> Adding support for new machines should be only additional two
> lines of assembly per machine after these patches.
>
> Regards,
>
> Tony
>
> ---
>
> Tony Lindgren (5):
> =A0 =A0 =A0omap: Remove code configuring the DEBUG_LL serial port using u=
ncompress code
> =A0 =A0 =A0omap: Use inituart to configure the debug serial port based on=
 machine ID
> =A0 =A0 =A0omap: Add support for CONFIG_AUTO_ZRELADDR for DEBUG_LL
> =A0 =A0 =A0omap: Combine debug-macro.S for omap1 and omap2+
> =A0 =A0 =A0omap: Add CONFIG_AUTO_ZRELADDR and CONFIG_ARM_PATCH_PHYS_VIRT =
to defconfigs
>
>
> =A0arch/arm/configs/omap1_defconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02
> =A0arch/arm/configs/omap2plus_defconfig =A0 =A0 =A0 =A0 =A0 | =A0 =A02
> =A0arch/arm/mach-omap1/include/mach/debug-macro.S | =A0 98 ---------
> =A0arch/arm/mach-omap1/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A07 +
> =A0arch/arm/mach-omap2/include/mach/debug-macro.S | =A0138 -------------
> =A0arch/arm/mach-omap2/serial.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A07 +
> =A0arch/arm/plat-omap/include/plat/debug-macro.S =A0| =A0257 ++++++++++++=
++++++++++++
> =A0arch/arm/plat-omap/include/plat/serial.h =A0 =A0 =A0 | =A0 34 ---
> =A0arch/arm/plat-omap/include/plat/uncompress.h =A0 | =A0 32 +--
> =A09 files changed, 284 insertions(+), 293 deletions(-)
> =A0create mode 100644 arch/arm/plat-omap/include/plat/debug-macro.

Boot tested linux-next branch with omap2plus_defconfig using NFS filesystem
along with the above 5 patch series and
2 patch series (Allow using machine ID for DEBUG_LL macros)
on Omap 2420,2430,3430 SDPs and Omap4 blaze.

Tested-by: Sourav Poddar<sourav.poddar@ti.com>
