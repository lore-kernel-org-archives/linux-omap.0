From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 09/22] OMAP2: add voltage domains and connect to
	powerdomains
Date: Wed, 7 Sep 2011 12:39:36 +0200
Message-ID: <CAORVsuXd2eeSs_TFu+stJge6tqQzO+4d0FcnmDPMHnChLgCuiQ@mail.gmail.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
	<1314639355-12713-10-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314639355-12713-10-git-send-email-khilman@ti.com>
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
> Create basic voltagedomains for OMAP2 and associate OMAP2 powerdomains
> with the newly created voltage domains.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A03 +-
> =A0arch/arm/mach-omap2/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 +
> =A0arch/arm/mach-omap2/powerdomains2xxx_data.c =A0 | =A0 =A04 +++
> =A0arch/arm/mach-omap2/voltage.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A01 +
> =A0arch/arm/mach-omap2/voltagedomains2xxx_data.c | =A0 32 +++++++++++++++=
++++++++++
> =A05 files changed, 41 insertions(+), 1 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/voltagedomains2xxx_data.c
>
...

> diff --git a/arch/arm/mach-omap2/voltagedomains2xxx_data.c b/arch/arm/mac=
h-omap2/voltagedomains2xxx_data.c
> new file mode 100644
> index 0000000..69ff261
> --- /dev/null
> +++ b/arch/arm/mach-omap2/voltagedomains2xxx_data.c
> @@ -0,0 +1,32 @@
> +/*
> + * OMAP3 voltage domain data
> + *
> + * Copyright (C) 2007, 2010 Texas Instruments, Inc.
2011?

Regards,
Jean
