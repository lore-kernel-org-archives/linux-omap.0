From: Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Subject: Re: [RFC][PATCH 2/9] ARM: OMAP3: cpuidle - remove next_valid_state
	function
Date: Fri, 23 Mar 2012 13:21:23 +0100
Message-ID: <CAORVsuVMSF-LEuGfkFWjm6QLv79RM4ewz4sZqNdWj66K55iB-w@mail.gmail.com>
References: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
	<1332494794-7810-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1332494794-7810-2-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: khilman-l0cyMroinI0@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Daniel,

On Fri, Mar 23, 2012 at 10:26 AM, Daniel Lezcano
<daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> As we will be able to remove C-states from userspace with the sysfs
> API, this function is no longer needed. We remove it and that simplifies
> the code for more consolidation.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 85 +--------------------------=
----------
> =A01 files changed, 2 insertions(+), 83 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpui=
dle34xx.c
> index d67431a..65b4e7aa 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -164,84 +164,6 @@ return_sleep_time:
> =A0}
>
> =A0/**
> - * next_valid_state - Find next valid C-state
> - * @dev: cpuidle device
> - * @drv: cpuidle driver
> - * @index: Index of currently selected c-state
> - *
> - * If the state corresponding to index is valid, index is returned back
> - * to the caller. Else, this function searches for a lower c-state which=
 is
> - * still valid (as defined in omap3_power_states[]) and returns its inde=
x.
> - *
> - * A state is valid if the 'valid' field is enabled and
> - * if it satisfies the enable_off_mode condition.
> - */
> -static int next_valid_state(struct cpuidle_device *dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_driver *drv,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int index)
> -{
> - =A0 =A0 =A0 struct cpuidle_state_usage *curr_usage =3D &dev->states_usa=
ge[index];
> - =A0 =A0 =A0 struct cpuidle_state *curr =3D &drv->states[index];
> - =A0 =A0 =A0 struct omap3_idle_statedata *cx =3D cpuidle_get_statedata(c=
urr_usage);
> - =A0 =A0 =A0 u32 mpu_deepest_state =3D PWRDM_POWER_RET;
> - =A0 =A0 =A0 u32 core_deepest_state =3D PWRDM_POWER_RET;
> - =A0 =A0 =A0 int next_index =3D -1;
> -
> - =A0 =A0 =A0 if (enable_off_mode) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpu_deepest_state =3D PWRDM_POWER_OFF;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Erratum i583: valable for ES rev < Es1=
.2 on 3630.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* CORE OFF mode is not supported in a st=
able form, restrict
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* instead the CORE state to RET.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRAT=
UM_i583))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 core_deepest_state =3D PWRD=
M_POWER_OFF;
> - =A0 =A0 =A0 }
I am OK to remove the function but some of the code needs to stay (can
be moved into enter_idle_bm).
The errata code is needed.

> -
> - =A0 =A0 =A0 /* Check if current state is valid */
> - =A0 =A0 =A0 if ((cx->valid) &&
> - =A0 =A0 =A0 =A0 =A0 (cx->mpu_state >=3D mpu_deepest_state) &&
> - =A0 =A0 =A0 =A0 =A0 (cx->core_state >=3D core_deepest_state)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return index;
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int idx =3D OMAP3_NUM_STATES - 1;
On OMAP3 not all the power states combinations are allowed, so this
code looks for a C-state which satisfies the enable_off_mode flag.
I am planning to remove the enable_off_mode flag but this has to come
with the per-device PM QoS constraints code.

> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Reach the current state starting at high=
est C-state */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (; idx >=3D 0; idx--) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (&drv->states[idx] =3D=
=3D curr) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next_index =
=3D idx;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Should never hit this condition */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(next_index =3D=3D -1);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Drop to next valid state.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Start search from the next (lower) sta=
te.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 idx--;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (; idx >=3D 0; idx--) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cx =3D cpuidle_get_statedat=
a(&dev->states_usage[idx]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((cx->valid) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cx->mpu_state >=3D=
 mpu_deepest_state) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cx->core_state >=
=3D core_deepest_state)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next_index =
=3D idx;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* C1 is always valid.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* So, no need to check for 'next_index =
=3D=3D -1' outside
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* this loop.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 return next_index;
> -}
> -
> -/**
> =A0* omap3_enter_idle_bm - Checks for any bus activity
> =A0* @dev: cpuidle device
> =A0* @drv: cpuidle driver
> @@ -254,7 +176,6 @@ static int omap3_enter_idle_bm(struct cpuidle_device =
*dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct cpu=
idle_driver *drv,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int index)
> =A0{
> - =A0 =A0 =A0 int new_state_idx;
> =A0 =A0 =A0 =A0u32 core_next_state, per_next_state =3D 0, per_saved_state=
 =3D 0, cam_state;
> =A0 =A0 =A0 =A0struct omap3_idle_statedata *cx;
> =A0 =A0 =A0 =A0int ret;
> @@ -265,7 +186,7 @@ static int omap3_enter_idle_bm(struct cpuidle_device =
*dev,
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0cam_state =3D pwrdm_read_pwrst(cam_pd);
> =A0 =A0 =A0 =A0if (cam_state =3D=3D PWRDM_POWER_ON) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_state_idx =3D drv->safe_state_index;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 index =3D drv->safe_state_index;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto select_state;
> =A0 =A0 =A0 =A0}
>
> @@ -292,10 +213,8 @@ static int omap3_enter_idle_bm(struct cpuidle_device=
 *dev,
> =A0 =A0 =A0 =A0if (per_next_state !=3D per_saved_state)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm_set_next_pwrst(per_pd, per_next_stat=
e);
>
> - =A0 =A0 =A0 new_state_idx =3D next_valid_state(dev, drv, index);
> -
> =A0select_state:
> - =A0 =A0 =A0 ret =3D omap3_enter_idle(dev, drv, new_state_idx);
> + =A0 =A0 =A0 ret =3D omap3_enter_idle(dev, drv, index);
>
> =A0 =A0 =A0 =A0/* Restore original PER state if it was modified */
> =A0 =A0 =A0 =A0if (per_next_state !=3D per_saved_state)
> --
> 1.7.5.4
>

Regards,
Jean
