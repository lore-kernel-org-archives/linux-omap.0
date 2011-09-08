From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 12/25] OMAP: Add support to allocate the memory for secure
	RAM
Date: Thu, 8 Sep 2011 21:19:12 +0200
Message-ID: <CAORVsuV8+zMzwT+PeWTo6TgWeEYfcSQdjY_kv4FcURohVoT=hw@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-13-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315144466-9395-13-git-send-email-santosh.shilimkar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, rnayak@ti.com
List-Id: linux-omap@vger.kernel.org

On Sun, Sep 4, 2011 at 3:54 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Allocate the memory to save secure ram context which needs
> to be done when MPU is hitting off mode.
>
> The ROM code expects a physical address to this memory
> and hence use memblock APIs to reserve this memory as part
> of .reserve() callback.
>
> Maximum possible size is allocated and can cater to OMAP3XXX / OMAP4XXX
> secure RAM size requirements.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> =A0arch/arm/mach-omap2/include/mach/omap-secure.h | =A0 =A04 +++
> =A0arch/arm/mach-omap2/omap-secure.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 29 =
++++++++++++++++++++++++
> =A0arch/arm/plat-omap/common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A03 ++
> =A03 files changed, 36 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/include/mach/omap-secure.h b/arch/arm/ma=
ch-omap2/include/mach/omap-secure.h
> index 26e7bcc..e2f95a0 100644
> --- a/arch/arm/mach-omap2/include/mach/omap-secure.h
> +++ b/arch/arm/mach-omap2/include/mach/omap-secure.h
> @@ -26,6 +26,8 @@
> =A0#define FLAG_FIQ_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x1
> =A0#define NO_FLAG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00x0
>
> +/* Maximum Secure memory storage size */
> +#define OMAP_SECURE_RAM_STORAGE =A0 =A0 =A0 =A0(88 * SZ_1K)
Is this valid for all supported devices? How to differentiate
variations in the size for new chips variants in the future?

Regards,
Jean
