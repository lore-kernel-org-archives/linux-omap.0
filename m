From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 00/12] OMAP: voltage cleanup part C: VP cleanup
Date: Wed, 7 Sep 2011 21:11:41 +0200
Message-ID: <CAORVsuWMC-M96AcKORvuDdUUpTzgzfboNizySoAO-z3Rj=o0fw@mail.gmail.com>
References: <1314640692-3386-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314640692-3386-1-git-send-email-khilman@ti.com>
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

On Mon, Aug 29, 2011 at 7:58 PM, Kevin Hilman <khilman@ti.com> wrote:
> This series focuses on cleanup and better abstraction in the voltage
> processor (VP) layer.
>
> Available in the pm-wip/voltdm_c branch of my linux-omap-pm tree
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
>
> Applies on v3.1-rc3 + the part A & B series.
>
> Kevin
>

Some comments have been sent on this patch set, otherwise OK after review.

FWIW:
Acked-by: Jean Pihet <j-pihet@ti.com>

Regards,
Jean

>
> Kevin Hilman (11):
> =A0OMAP3+: VP: cleanup: move VP instance into voltdm, misc. renames
> =A0OMAP3+: voltage: remove unneeded debugfs interface
> =A0OMAP3+: VP: struct omap_vp_common: replace shift with __ffs(mask)
> =A0OMAP3+: VP: move SoC-specific sys clock rate retreival late init
> =A0OMAP3+: VP: move timing calculation/config into VP init
> =A0OMAP3+: VP: create VP helper function for updating error gain
> =A0OMAP3+: VP: remove omap_vp_runtime_data
> =A0OMAP3+: VP: move voltage scale function pointer into struct
> =A0 =A0voltagedomain
> =A0OMAP3+: VP: update_errorgain(): return error if VP
> =A0OMAP3+: VP: remove unused omap_vp_get_curr_volt()
> =A0OMAP3+: VP: combine setting init voltage into common function
>
> Todd Poynor (1):
> =A0OMAP: VP: Explicitly mask VPVOLTAGE field
>
> =A0arch/arm/mach-omap2/smartreflex.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 29 ++-
> =A0arch/arm/mach-omap2/vc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 22 +--
> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0161=
 ++------------
> =A0arch/arm/mach-omap2/voltage.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 24=
 +--
> =A0arch/arm/mach-omap2/voltagedomains3xxx_data.c | =A0 18 +-
> =A0arch/arm/mach-omap2/voltagedomains44xx_data.c | =A0 23 ++-
> =A0arch/arm/mach-omap2/vp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0292 +++++++++----------------
> =A0arch/arm/mach-omap2/vp.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 91 +++-----
> =A0arch/arm/mach-omap2/vp3xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 16 +-
> =A0arch/arm/mach-omap2/vp44xx_data.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 19 +-
> =A010 files changed, 226 insertions(+), 469 deletions(-)
>
> --
> 1.7.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
