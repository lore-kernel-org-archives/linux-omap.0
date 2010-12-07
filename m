From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH] MFD: TWL/TPS: fix twl_probe section mismatch warning in mfd/twl-core.c
Date: Tue, 7 Dec 2010 09:36:09 +0800
Message-ID: <AANLkTimXPFROMQ_fF4Od-jw3aDY0WZQgc=x14=VcFM3d@mail.gmail.com>
References: <alpine.DEB.2.00.1012061734590.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1012061734590.13430@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 7, 2010 at 8:35 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Fix the following section mismatch warning when building omap2plus_de=
fconfig:
>
> WARNING: vmlinux.o(.data+0x47d7c): Section mismatch in reference from=
 the variable twl_driver to the function .init.text:twl_probe()
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
> =A0drivers/mfd/twl-core.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 35275ba..615cf38 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -969,7 +969,7 @@ static int twl_remove(struct i2c_client *client)
> =A0}
>
> =A0/* NOTE: =A0this driver only handles a single twl4030/tps659x0 chi=
p */
> -static int __init
> +static int

I think we might change __init to __devinit.

> =A0twl_probe(struct i2c_client *client, const struct i2c_device_id *i=
d)
> =A0{
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 status;
> --

Thanks,
--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
