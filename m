From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 1/3] cpuidle: refactor out cpuidle_enter_state
Date: Wed, 4 Jan 2012 15:08:02 +0100
Message-ID: <CAORVsuV-=h9qVcFB7ezEOV2ptLMT=FJcdvaspLj-qAzFK4-NEQ@mail.gmail.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
	<1324426147-16735-2-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1324426147-16735-2-git-send-email-ccross@android.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@android.com>
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-tegra@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Colin,

On Wed, Dec 21, 2011 at 1:09 AM, Colin Cross <ccross@android.com> wrote:
> Split the code to enter a state and update the stats into a helper
> function, cpuidle_enter_state, and export it. =A0This function will
> be called by the coupled state code to handle entering the safe
> state and the final coupled state.
>
> Signed-off-by: Colin Cross <ccross@android.com>
> ---
> =A0drivers/cpuidle/cpuidle.c | =A0 43 +++++++++++++++++++++++++++++------=
--------
> =A0drivers/cpuidle/cpuidle.h | =A0 =A02 ++
> =A02 files changed, 31 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 06ce268..1486b3c 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -54,6 +54,34 @@ static void cpuidle_kick_cpus(void) {}
> =A0static int __cpuidle_register_device(struct cpuidle_device *dev);
>
> =A0/**
> + * cpuidle_enter_state
> + *
> + * enter the state and update stats
> + */
> +int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_drive=
r *drv,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int next_state)
> +{
> + =A0 =A0 =A0 int entered_state;
> + =A0 =A0 =A0 struct cpuidle_state *target_state;
> +
> + =A0 =A0 =A0 target_state =3D &drv->states[next_state];
> +
> + =A0 =A0 =A0 entered_state =3D target_state->enter(dev, drv, next_state);
> +
> + =A0 =A0 =A0 if (entered_state >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Update cpuidle counters */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* This can be moved to within driver enter=
 routine
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* but that results in multiple copies of=
 same code.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->states_usage[entered_state].time +=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned l=
ong long)dev->last_residency;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->states_usage[entered_state].usage++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return entered_state;
> +}
> +
> +/**
> =A0* cpuidle_idle_call - the main idle loop
> =A0*
> =A0* NOTE: no locks or semaphores should be used here
> @@ -63,7 +91,6 @@ int cpuidle_idle_call(void)
> =A0{
> =A0 =A0 =A0 =A0struct cpuidle_device *dev =3D __this_cpu_read(cpuidle_dev=
ices);
> =A0 =A0 =A0 =A0struct cpuidle_driver *drv =3D cpuidle_get_driver();
> - =A0 =A0 =A0 struct cpuidle_state *target_state;
> =A0 =A0 =A0 =A0int next_state, entered_state;
>
> =A0 =A0 =A0 =A0if (off)
> @@ -92,26 +119,14 @@ int cpuidle_idle_call(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 target_state =3D &drv->states[next_state];
> -
> =A0 =A0 =A0 =A0trace_power_start(POWER_CSTATE, next_state, dev->cpu);
> =A0 =A0 =A0 =A0trace_cpu_idle(next_state, dev->cpu);
>
> - =A0 =A0 =A0 entered_state =3D target_state->enter(dev, drv, next_state);
> + =A0 =A0 =A0 entered_state =3D cpuidle_enter_state(dev, drv, next_state);
>
> =A0 =A0 =A0 =A0trace_power_end(dev->cpu);
> =A0 =A0 =A0 =A0trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
The cpu_idle traces are only present in this function and not in
cpuidle_enter_state. Is that expected? Can all the transitions from
all the cpus get traced that way?

Regards,
Jean
