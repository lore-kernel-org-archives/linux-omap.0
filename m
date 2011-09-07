From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 13/22] OMAP2+: voltage: keep track of powerdomains in each
	voltagedomain
Date: Wed, 7 Sep 2011 11:23:21 +0200
Message-ID: <CAORVsuU27kNiJAt-YRgfJ5i0=ZpfcDhNfY+kYK+AnKurDHDPfQ@mail.gmail.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
	<1314639355-12713-14-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314639355-12713-14-git-send-email-khilman@ti.com>
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

Hi Kevin,

On Mon, Aug 29, 2011 at 7:35 PM, Kevin Hilman <khilman@ti.com> wrote:
> When a powerdomain is registered and it has an associated voltage domain,
> add the powerdomain to the voltagedomain using voltdm_add_pwrdm().
>
> Also add voltagedomain iterator helper functions to iterate over all
> registered voltagedomains and all powerdomains associated with a
> voltagedomain.
>
> Modeled after a similar relationship between clockdomains and powerdomain=
s.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/powerdomain.c | =A0 =A02 +
> =A0arch/arm/mach-omap2/powerdomain.h | =A0 =A02 +
> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 | =A0 80 +++++++++++++++++++++++=
++++++++++++++
> =A0arch/arm/mach-omap2/voltage.h =A0 =A0 | =A0 10 +++++
> =A04 files changed, 94 insertions(+), 0 deletions(-)
>
...

> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index 966aa88..b41d9f1 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -19,6 +19,8 @@
> =A0#include "vc.h"
> =A0#include "vp.h"
>
> +struct powerdomain;
> +
> =A0/* XXX document */
> =A0#define VOLTSCALE_VPFORCEUPDATE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
> =A0#define VOLTSCALE_VCBYPASS =A0 =A0 =A0 =A0 =A0 =A0 2
> @@ -55,12 +57,15 @@ struct omap_vfsm_instance_data {
> =A0* @name: Name of the voltage domain which can be used as a unique iden=
tifier.
> =A0* @scalable: Whether or not this voltage domain is scalable
> =A0* @node: list_head linking all voltage domains
> + * @pwrdm_node: list_head linking all powerdomains in this voltagedomain
> =A0* @vdd: to be removed
> + * @pwrdms: powerdomains in this voltagedomain
> =A0*/
> =A0struct voltagedomain {
> =A0 =A0 =A0 =A0char *name;
> =A0 =A0 =A0 =A0bool scalable;
> =A0 =A0 =A0 =A0struct list_head node;
> + =A0 =A0 =A0 struct list_head pwrdm_list;
> =A0 =A0 =A0 =A0struct omap_vdd_info *vdd;
> =A0};
The kerneldoc is not reflecting the code for struct voltagedomain.

Regards,
Jean
