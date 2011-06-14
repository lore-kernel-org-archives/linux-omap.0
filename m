From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] power: opp: Fix rcu_dereference_check()
	without protection!
Date: Tue, 14 Jun 2011 10:38:37 -0500
Message-ID: <BANLkTimKHsGCrbZ5FhYOyJC8+pASUD-nDg@mail.gmail.com>
References: <1308056600-17601-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1308056600-17601-1-git-send-email-santosh.shilimkar@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 14, 2011 at 08:03, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> With RCU debug options enabled, below warning is observed.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> [ INFO: suspicious rcu_dereference_check() usage. ]
> ---------------------------------------------------
> drivers/base/power/opp.c:151 invoked rcu_dereference_check() without prot=
ection!
>
> other info that might help us debug this:
>
> rcu_scheduler_active =3D 1, debug_locks =3D 1
> no locks held by swapper/1.
> ...
>
> ---------------------------------------------------
>
> Fix the same by protecting it with rcu_read lock.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> =A0drivers/base/power/opp.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 56a6899..cbed5e1 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -148,7 +148,9 @@ unsigned long opp_get_voltage(struct opp *opp)
> =A0 =A0 =A0 =A0struct opp *tmp_opp;
> =A0 =A0 =A0 =A0unsigned long v =3D 0;
>
> + =A0 =A0 =A0 rcu_read_lock();
> =A0 =A0 =A0 =A0tmp_opp =3D rcu_dereference(opp);
> + =A0 =A0 =A0 rcu_read_unlock();
> =A0 =A0 =A0 =A0if (unlikely(IS_ERR_OR_NULL(tmp_opp)) || !tmp_opp->availab=
le)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: Invalid parameters\n", __func_=
_);
> =A0 =A0 =A0 =A0else
NAK. please read the Documentation/power/opp.txt
the usage is as follows:
rcu_read_lock();
opp =3D opp_find_freq_ceil();
voltage =3D opp_get_voltage(opp);
rcu_read_unlock();

the reason for this is that the opp pointer is not safe if we lock
just the dereferencing.

Regards,
Nishanth Menon
