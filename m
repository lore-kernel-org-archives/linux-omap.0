From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH 10/11] omap4: thermal: add basic CPU
	thermal zone
Date: Mon, 28 May 2012 15:03:26 +0530
Message-ID: <CAMQu2gxNa4sPMKPLXGkKz_wkbQF8bTYipo4910p-ui9WNdeVFQ@mail.gmail.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
	<1337934361-1606-11-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1337934361-1606-11-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: amit.kucheria@linaro.org, balbi@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 25, 2012 at 1:56 PM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> This patch exposes OMAP4 thermal sensor as a thermal zone
> named "cpu". Only thermal creation is done here.
>
> TODO:
>
> =A0- Add cooling bindings
> =A0- Add extrapolation rules
>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
> =A0drivers/thermal/Kconfig =A0 =A0 =A0 =A0 | =A0 12 ++++++
> =A0drivers/thermal/Makefile =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/thermal/omap-bandgap.c =A0| =A0 =A01 +
> =A0drivers/thermal/omap-bandgap.h =A0| =A0 12 ++++++
> =A0drivers/thermal/omap4-thermal.c | =A0 72 +++++++++++++++++++++++++++++=
++++++++++
> =A05 files changed, 98 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/thermal/omap4-thermal.c
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index ffdd240..2e82797 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -39,3 +39,15 @@ config OMAP_BANDGAP
> =A0 =A0 =A0 =A0 =A0This includes alert interrupts generation and also the=
 TSHUT
> =A0 =A0 =A0 =A0 =A0support.
>
> +config OMAP4_THERMAL
> + =A0 =A0 =A0 bool "Texas Instruments OMAP4 thermal support"
> + =A0 =A0 =A0 depends on OMAP_BANDGAP
> + =A0 =A0 =A0 depends on ARCH_OMAP4
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 If you say yes here you get thermal support for the Tex=
as Instruments
> + =A0 =A0 =A0 =A0 OMAP4 SoC family. The current chip supported are:
> + =A0 =A0 =A0 =A0 =A0- OMAP4460
> +
It's more of IP feature than OMAP specific, so something like

config  HAVE_BANDGAP_THERMAL_SUPPORT

and then let processor's which support enable it. That OMAP varients
in AMXX etc if needed can make use of it.

If you agree, then rest of the driver also can be cleaned to avoid
omap_* in file names and variables.

Apart from this minor comment, rest of the patch looks fine to me.

Regards
Santosh
