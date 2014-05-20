From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 2/4] omap prcm changes for v3.16 merge window
Date: Mon, 19 May 2014 18:56:37 -0700
Message-ID: <20140520015636.GJ15793@atomide.com>
References: <20140520013050.GF15793@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140520013050.GF15793@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [140519 18:31]:
> The following changes since commit be2d62844819b3536233b7fc726b8f17d9fa7f05:
> 
>   ARM: OMAP: debug-leds: raw read and write endian fix (2014-05-08 07:09:55 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.16/prcm-signed
> 
> for you to fetch changes up to ea351c1603df0607b68eb4663b82ba7a70519d2e:
> 
>   Merge tag 'for-v3.16/prcm-cleanup-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.16/prcm (2014-05-16 15:26:22 -0700)
> 
> ----------------------------------------------------------------
> 
> PRCM changes for omaps. I ended up merging these with the
> big endian changes because of the merge conflicts for read
> and write operations. Via Paul Walmsley <paul@pwsan.com>:
> 
> Some OMAP PRCM cleanup patches.  These help prepare to convert the PRCM
> code into drivers.
> 
> Basic build, boot, and PM test results are available here:
> 
> http://www.pwsan.com/omap/testlogs/prcm-cleanup-v3.16/20140515213244/

Note that pulling this will also pull in the earlier trivial big
endian changes I posted on the 8th of May but did not make the lists.

Regards,

Tony
 
> ----------------------------------------------------------------
> Tero Kristo (10):
>       ARM: OMAP3: CM: remove a few OMAP34XX_CM_REGADDR defines
>       ARM: OMAP2+: prcm: add omap_test_timeout to prcm-common.h
>       ARM: OMAP2/3: CM: remove some external dependencies
>       ARM: OMAP4: CM: use cm_base* in register address calculations
>       ARM: OMAP2+: PRCM: cleanup some header includes
>       ARM: OMAP2+: PRM: remove unnecessary cpu_is_XXX calls from prm_init / exit
>       ARM: OMAP3/4: PRM: provide io chain reconfig function through irq setup
>       ARM: OMAP3/OMAP4: PRM: add prm_features flags and add IO wakeup under it
>       ARM: OMAP3/4: PRM: add support of late_init call to prm_ll_ops
>       ARM: OMAP4: PRCM: remove references to cm-regbits-44xx.h from PRCM core files
> 
> Tony Lindgren (1):
>       Merge tag 'for-v3.16/prcm-cleanup-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.16/prcm
> 
>  arch/arm/mach-omap2/clockdomain.h                  |  3 ++-
>  arch/arm/mach-omap2/cm2xxx.c                       | 15 ++-----------
>  arch/arm/mach-omap2/cm33xx.h                       |  3 ---
>  arch/arm/mach-omap2/cm3xxx.c                       | 25 ++++++++--------------
>  arch/arm/mach-omap2/cm3xxx.h                       |  5 ++---
>  arch/arm/mach-omap2/cm44xx.c                       | 11 ++++------
>  arch/arm/mach-omap2/cm_common.c                    |  2 +-
>  arch/arm/mach-omap2/cminst44xx.c                   | 10 ++++++---
>  .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  1 +
>  arch/arm/mach-omap2/powerdomain-common.c           |  1 -
>  arch/arm/mach-omap2/powerdomain.c                  |  1 +
>  arch/arm/mach-omap2/powerdomain.h                  |  3 +--
>  arch/arm/mach-omap2/prcm-common.h                  | 24 +++++++++++++++++++++
>  arch/arm/mach-omap2/prcm_mpu44xx.h                 |  1 -
>  arch/arm/mach-omap2/prm.h                          | 10 +++++++++
>  arch/arm/mach-omap2/prm2xxx.c                      | 13 +----------
>  arch/arm/mach-omap2/prm2xxx_3xxx.c                 |  1 -
>  arch/arm/mach-omap2/prm33xx.c                      |  1 -
>  arch/arm/mach-omap2/prm3xxx.c                      | 22 +++++++++----------
>  arch/arm/mach-omap2/prm44xx.c                      | 20 ++++++++---------
>  arch/arm/mach-omap2/prm_common.c                   | 17 +++++++++------
>  21 files changed, 95 insertions(+), 94 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
