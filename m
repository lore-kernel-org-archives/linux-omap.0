From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] omap: boards w/ wl12xx should select
	REGULATOR_FIXED_VOLTAGE
Date: Thu, 16 Dec 2010 08:52:04 +0200
Message-ID: <AANLkTik+PBarJzgyR67dzgzjB_H17O1+=9_T50qp6jD0@mail.gmail.com>
References: <1290593090-6288-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1290593090-6288-1-git-send-email-ohad@wizery.com>
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

Hi Tony,

On Wed, Nov 24, 2010 at 12:04 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Power to the wl12xx wlan device is controlled by a fixed regulator.
>
> Boards that have the wl12xx should select REGULATOR_FIXED_VOLTAGE so
> users will not be baffled.

Not sure if you picked this up ?

We need it because otherwise new wl12xx users can spend many hours
until they figure out what's the problem..

Please tell me if there's any problem with this one.

Thanks,
Ohad.

>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
> =A0arch/arm/mach-omap2/Kconfig | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index fc3a181..cc386da 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -190,6 +190,7 @@ config MACH_OMAP3_PANDORA
> =A0 =A0 =A0 =A0depends on ARCH_OMAP3
> =A0 =A0 =A0 =A0default y
> =A0 =A0 =A0 =A0select OMAP_PACKAGE_CBB
> + =A0 =A0 =A0 select REGULATOR_FIXED_VOLTAGE
>
> =A0config MACH_OMAP3_TOUCHBOOK
> =A0 =A0 =A0 =A0bool "OMAP3 Touch Book"
> @@ -235,6 +236,7 @@ config MACH_OMAP_ZOOM2
> =A0 =A0 =A0 =A0select SERIAL_8250
> =A0 =A0 =A0 =A0select SERIAL_CORE_CONSOLE
> =A0 =A0 =A0 =A0select SERIAL_8250_CONSOLE
> + =A0 =A0 =A0 select REGULATOR_FIXED_VOLTAGE
>
> =A0config MACH_OMAP_ZOOM3
> =A0 =A0 =A0 =A0bool "OMAP3630 Zoom3 board"
> @@ -244,6 +246,7 @@ config MACH_OMAP_ZOOM3
> =A0 =A0 =A0 =A0select SERIAL_8250
> =A0 =A0 =A0 =A0select SERIAL_CORE_CONSOLE
> =A0 =A0 =A0 =A0select SERIAL_8250_CONSOLE
> + =A0 =A0 =A0 select REGULATOR_FIXED_VOLTAGE
>
> =A0config MACH_CM_T35
> =A0 =A0 =A0 =A0bool "CompuLab CM-T35 module"
> --
> 1.7.0.4
>
>
