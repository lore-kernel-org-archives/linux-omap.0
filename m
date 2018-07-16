From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] arm: Convert arm boot_lock to raw
Date: Mon, 16 Jul 2018 09:50:54 +0530
Message-ID: <20180716042054.oniidhhpcx2kyetw@vireshk-i7>
References: <20180711110037.12928-1-bigeasy@linutronix.de>
 <20180711110037.12928-2-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180711110037.12928-2-bigeasy@linutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Barry Song <baohua@kernel.org>, linux-samsung-soc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Frank Rowand <frank.rowand@am.sony.com>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>, Patrice Chotard <patrice.chotard@st.com>, Maxime Ripard <maxime.ripard@bootlin.com>, David Brown <david.brown@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, Wei Xu <xuwei5@hisilicon.com>, Viresh Kumar <vireshk@kernel.org>, Andy Gross <andy.gross@linaro.org>, tglx@linutronix.de, linux-omap@vger.kernel.org, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 11-07-18, 13:00, Sebastian Andrzej Siewior wrote:
> From: Frank Rowand <frank.rowand@am.sony.com>
> =

> The arm boot_lock is used by the secondary processor startup code.  The l=
ocking
> task is the idle thread, which has idle->sched_class =3D=3D &idle_sched_c=
lass.
> idle_sched_class->enqueue_task =3D=3D NULL, so if the idle task blocks on=
 the
> lock, the attempt to wake it when the lock becomes available will fail:
> =

> try_to_wake_up()
>    ...
>       activate_task()
>          enqueue_task()
>             p->sched_class->enqueue_task(rq, p, flags)
> =

> Fix by converting boot_lock to a raw spin lock.
> =

> Cc: "Andreas F=E4rber" <afaerber@suse.de>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-soc@vger.kernel.org
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> Link: http://lkml.kernel.org/r/4E77B952.3010606@am.sony.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Tested-by: Krzysztof Kozlowski <krzk@kernel.org> [Exynos5422 Linaro PM-QA]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm/mach-spear/platsmp.c     | 10 +++++-----

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- =

viresh
