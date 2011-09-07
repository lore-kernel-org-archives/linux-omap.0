From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 14/22] OMAP2+: voltage: split voltage controller (VC) code
	into dedicated layer
Date: Wed, 7 Sep 2011 12:42:20 +0200
Message-ID: <CAORVsuWEZmChCjy8dJV+acosr_8N9XN0VL8-L6HWaKnZkoqqYA@mail.gmail.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
	<1314639355-12713-15-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314639355-12713-15-git-send-email-khilman@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Kevin,

On Mon, Aug 29, 2011 at 7:35 PM, Kevin Hilman <khilman@ti.com> wrote:
> As part of the voltage layer cleanup, split out VC specific code into
> a dedicated VC layer. =A0This patch primarily just moves VC code from
> voltage.c into vc.c, and adds prototypes to vc.h.
>
> No functional changes.
>
> For readability, each function was given a local 'vc' pointer:
>
> =A0 =A0struct omap_vc_instance_data *vc =3D voltdm->vdd->vc_data;
>
> and a global replace of s/vdd->vc_data/vc/ was done.
>
> Also vc_init was renamed to vc_init_channel to reflect that this is
> per-VC channel initializtion.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/Makefile =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap2/vc.c =A0 =A0 =A0| =A0276 +++++++++++++++++++++++++=
++++++++++++++++
> =A0arch/arm/mach-omap2/vc.h =A0 =A0 =A0| =A0 12 ++
> =A0arch/arm/mach-omap2/voltage.c | =A0264 +------------------------------=
--------
> =A04 files changed, 293 insertions(+), 261 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/vc.c
>
...

> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> new file mode 100644
> index 0000000..98f5a4b
> --- /dev/null
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -0,0 +1,276 @@

The copyright notice is missing.

> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +
> +#include <plat/cpu.h>
> +
> +#include "voltage.h"
> +#include "vc.h"
> +#include "prm-regbits-34xx.h"
> +#include "prm-regbits-44xx.h"
> +#include "prm44xx.h"
> +
...

Regards,
Jean
