From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions:
 watchdog, UART, i2c
Date: Tue, 5 Oct 2010 11:50:55 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF3B2C94@dbde02.ent.ti.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
 <20100928201844.GI3117@atomide.com> <87tyl8rxwp.fsf@deeprootsystems.com>
 <20100930021819.GD3117@atomide.com> <877hi3i9cp.fsf@deeprootsystems.com>
 <87pqvvgt8g.fsf@deeprootsystems.com> <877hi3gqq7.fsf@deeprootsystems.com>
 <0680EC522D0CC943BC586913CF3768C003FF2DAF74@dbde02.ent.ti.com>
 <4CA60F88.4020303@ti.com>
 <alpine.DEB.2.00.1010042359170.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58849 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753967Ab0JEGVG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 02:21:06 -0400
In-Reply-To: <alpine.DEB.2.00.1010042359170.13816@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>



> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, October 05, 2010 11:32 AM
> To: Cousson, Benoit
> Cc: Nayak, Rajendra; Kevin Hilman; Tony Lindgren; linux-omap@vger.ker=
nel.org; Varadarajan, Charulatha; Raja,
> Govindraj
> Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: w=
atchdog, UART, i2c
>=20
> Hello Beno=EEt, Rajendra, Kevin,
>=20
> On Fri, 1 Oct 2010, Cousson, Benoit wrote:
>=20
> > The issue is that 2420 idlest does not reflect the real status of t=
he OCP bus
> > clock, but just the fact that the idle_req is asserted or not.
> >
> > So potentially, the IP is still not accessible when you think it is=
=2E
> > This imprecise external abort always happen when you try to access =
an IP that
> > is not properly clock.
> >
> > BTW, this is exactly the same kind of issue we have with FDIF and I=
SS on
> > OMAP4.
>=20
> Won't the new idle protocol resolve this for OMAP4 ?
>=20
> > The easy quick and dirty fix is to comment out the sysconfig struct=
ure in the
> > hwmod definition. You will then prevent any access to the sysconfig=
=2E
> > Otherwise, I'm quite sure that a small udelay(1000) can help fixing=
 such issue
> > as well.
> >
> > Do not forget that 2420 is the very first implementation of the PRC=
M +
> > smartidle mechanism... It was broken for most IPs at that time :-)
>=20
> Below is an untested patch to provide some mechanism to deal with thi=
s --
> I'd appreciate everyone's comments on this, particularly the comments=
 in
> the patch code on how to deal with this problem.

Hi Paul,

I'll test this patch to see if it solves the issue seen with i2c on n80=
0.
One minor comment of the changelog below..

>=20
>=20
> - Paul
>=20
> From: Paul Walmsley <paul@pwsan.com>
> Date: Mon, 4 Oct 2010 23:15:23 -0600
> Subject: [PATCH] OMAP: hwmod: add configurable device enable delay af=
ter PRCM IdleAck deasserts
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> Some IP blocks may require extra time to become ready for register
> reads/writes after the PRCM deasserts its IdleAck signal to the

Maybe it should say 'PRCM deasserts its IdleReq'

> module.  If an imprecise external abort happens during or shortly
> after the hwmod is enabled, extra time is needed[1].  For those
> modules, add a new struct omap_hwmod field, .enable_delay.  This fiel=
d
> represents the number of microseconds that the hwmod code should dela=
y
> before attempting to access the IP block's registers or relinquishing
> control to the calling code.
>=20
> Copious guidance is also provided to aid developers in determining th=
e
> appropriate hwmod value.
>=20
> This problem was identified by Kevin Hilman and Rajendra Nayak.
> Beno=EEt Cousson identified the solution.
>=20
> 1. http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36300.ht=
ml
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno=EEt Cousson <b-cousson@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c             |    3 ++
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |   33 ++++++++++++++++=
++++++++-
>  2 files changed, 34 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> index 955861a..fbcfe14 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1204,6 +1204,9 @@ int _omap_hwmod_enable(struct omap_hwmod *oh)
>=20
>  	r =3D _wait_target_ready(oh);
>  	if (!r) {
> +		if (oh->enable_delay)
> +			udelay(oh->enable_delay);
> +
>  		oh->_state =3D _HWMOD_STATE_ENABLED;
>=20
>  		/* Access the sysconfig only if the target is ready */
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/=
plat-omap/include/plat/omap_hwmod.h
> index c1835af..5a1e058 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -434,6 +434,7 @@ struct omap_hwmod_class {
>   * @main_clk: main clock: OMAP clock name
>   * @_clk: pointer to the main struct clk (filled in at runtime)
>   * @opt_clks: other device clocks that drivers can request (0..*)
> + * @enable_delay: number of microseconds to wait after IdleReq is de=
asserted
>   * @masters: ptr to array of OCP ifs that this hwmod can initiate on
>   * @slaves: ptr to array of OCP ifs that this hwmod can respond on
>   * @dev_attr: arbitrary device attributes that can be passed to the =
driver
> @@ -460,8 +461,35 @@ struct omap_hwmod_class {
>   * accesses to complete."  Modules may not have a main clock if the
>   * interface clock also serves as a main clock.
>   *
> - * Parameter names beginning with an underscore are managed internal=
ly by
> - * the omap_hwmod code and should not be set during initialization.
> + * On OMAP SoCs prior to OMAP4, some hwmods may require a non-zero
> + * @enable_delay value.  A hwmod needs a non-zero @enable_delay if a=
n
> + * imprecise external abort occurs while the hwmod is being enabled.
> + * This can happen if the hwmod takes a significant time to become
> + * ready for OCP transactions after the PRCM deasserts IdleAck to th=
e
> + * module.  @enable_delay specifies the number of microseconds for t=
he
> + * hwmod code to udelay() between the time that the PRCM deasserts t=
he
> + * IdleAck, and the time when the module is ready to handle register
> + * reads/writes.  Most hwmods shouldn't need anything here and can
> + * leave @enable_delay blank.  For hwmods that do need a value here,
> + * to estimate the required value, the best thing to do is to set th=
e
> + * IP block to run at the slowest interface and functional clock rat=
es
> + * and the lowest voltages.  First, try out a small value, say, 10
> + * microseconds, and keep increasing it until the kernel no longer
> + * crashes.  Then add a safety margin to the value that you arrived =
at
> + * -- say, 50% -- and specify the value in the structure record
> + * initializer for @enable_delay as (value + safety_margin).  Try no=
t
> + * to overestimate this number; if @enable_delay is too large, then
> + * energy will be wasted and the CPU will spin for an unnecessarily
> + * long time while enabling the device.  If @enable_delay is too
> + * small, the device will trigger an abort.  More information is
> + * available here:
> + * http://www.mail-archive.com/linux-omap@vger.kernel.org/msg36300.h=
tml
> + * XXX @enable_value will need to be taken into consideration by the
> + * omap_device code to determine whether the device's current wakeup
> + * latency constraint can be satisfied if the module is placed into =
idle.
> + *
> + * Parameter names beginning with an underscore are managed internal=
ly
> + * by the omap_hwmod code and should not be set during initializatio=
n.
>   */
>  struct omap_hwmod {
>  	const char			*name;
> @@ -484,6 +512,7 @@ struct omap_hwmod {
>  	void __iomem			*_mpu_rt_va;
>  	struct mutex			_mutex;
>  	struct list_head		node;
> +	u16				enable_delay;
>  	u16				flags;
>  	u8				_mpu_port_index;
>  	u8				msuspendmux_reg_id;
> --
> 1.7.1
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
