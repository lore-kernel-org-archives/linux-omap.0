From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 02/20] mfd: Add devm_mfd_add_devices() in list of
 managed interfaces
Date: Mon, 11 Apr 2016 10:15:10 +0100
Message-ID: <20160411091510.GP4592@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-3-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-3-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

Applied, thanks.

On Fri, 08 Apr 2016, Laxman Dewangan wrote:

> Add devm wrappers for the mfd_add_devices() in the list of managed
> interfaces.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>=20
> ---
> Changes from V1:
> - Reformat the commit message.
> - Remove devm_ for mfd_remove_devices() as this is not used.
>=20
>  Documentation/driver-model/devres.txt | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/driver-model/devres.txt b/Documentation/dr=
iver-model/devres.txt
> index 73b98df..7f8c416 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -317,6 +317,9 @@ MEM
>    devm_kvasprintf()
>    devm_kzalloc()
> =20
> +MFD
> + devm_mfd_add_devices()
> +
>  PCI
>    pcim_enable_device()	: after success, all PCI ops become managed
>    pcim_pin_device()	: keep PCI device enabled after release

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
