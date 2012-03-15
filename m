From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v2 5/8] ARM: OMAP2+: hwmod: ensure that SYSCONFIG bits are
 reprogrammed after a reset
Date: Wed, 14 Mar 2012 19:31:19 -0500
Message-ID: <CAB-zwWhAa3PprwDLzWLkBFUHPeJO3HN3M9mAZF=ohGTvP43jYA@mail.gmail.com>
References: <20120228053524.16278.59430.stgit@dusk>
 <20120228053657.16278.76132.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120228053657.16278.76132.stgit@dusk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

2012/2/27 Paul Walmsley <paul@pwsan.com>:
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_=
hwmod.c
> index db4ad41..aeb6f4c 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1490,13 +1490,22 @@ static int _reset(struct omap_hwmod *oh)
> =A0 =A0 =A0 =A0pr_debug("omap_hwmod: %s: resetting\n", oh->name);
>
> =A0 =A0 =A0 =A0if (oh->class->reset)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return oh->class->reset(oh);
> -
> - =A0 =A0 =A0 if (!oh->rst_lines_cnt)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return _ocp_softreset(oh);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh->class->reset(oh);
> + =A0 =A0 =A0 else if (!oh->rst_lines_cnt)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _ocp_softreset(oh);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < oh->rst_lines_cnt; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _assert_hardreset(oh, oh->r=
st_lines[i].name);

If we reached here the reset lines will be asserted, and then the code
below touches sysc registers on a module under reset.

This would crash on _setup->_setup_reset->_reset.

Adding a 'return 0' I believe fixes the behavior, boots the board and
leaves the hwmod under reset.

-	else
+	} else {
 		for (i =3D 0; i < oh->rst_lines_cnt; i++)
 			_assert_hardreset(oh, oh->rst_lines[i].name);
+		return 0;
+	}

>
> - =A0 =A0 =A0 for (i =3D 0; i < oh->rst_lines_cnt; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 _assert_hardreset(oh, oh->rst_lines[i].name=
);
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* OCP_SYSCONFIG bits need to be reprogrammed after a
> + =A0 =A0 =A0 =A0* softreset. =A0The _enable() function should be split t=
o avoid
> + =A0 =A0 =A0 =A0* the rewrite of the OCP_SYSCONFIG register.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (oh->class->sysc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _update_sysc_cache(oh);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _enable_sysc(oh);
> + =A0 =A0 =A0 }

Best Regards,

Omar
