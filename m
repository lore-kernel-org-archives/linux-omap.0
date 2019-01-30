From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
Date: Wed, 30 Jan 2019 22:53:00 +0100
Message-ID: <CAJZ5v0gnJ5DKvOO9OcJoMrGYpHfeQBt2Ec0pMW6=2q5aMoFpww@mail.gmail.com>
References: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
 <1548869162-6223-1-git-send-email-vincent.guittot@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1548869162-6223-1-git-send-email-vincent.guittot@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Biju Das <biju.das@bp.renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 30, 2019 at 6:26 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> A deadlock has been seen when swicthing clocksources which use PM runtime.
> The call path is:
> change_clocksource
>     ...
>     write_seqcount_begin
>     ...
>     timekeeping_update
>         ...
>         sh_cmt_clocksource_enable
>             ...
>             rpm_resume
>                 pm_runtime_mark_last_busy
>                     ktime_get
>                         do
>                             read_seqcount_begin
>                         while read_seqcount_retry
>     ....
>     write_seqcount_end
>
> Although we should be safe because we haven't yet changed the clocksource
> at that time, we can't because of seqcount protection.
>
> Use ktime_get_mono_fast_ns() instead which is lock safe for such case
>
> With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> monotonic across an update and as a result can goes backward. According to
> update_fast_timekeeper() description: "In the worst case, this can
> result is a slightly wrong timestamp (a few nanoseconds)". For
> PM runtime autosuspend, this means only that the suspend decision can
> be slightly sub optimal.
>
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Reported-by: Biju Das <biju.das@bp.renesas.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>
> Hi Rafael,
>
> Sorry, I sent the version with the typo mistake that generated the compilation error
> reported by kbuild-test-robot
>
> This version doesn't have the typo.

OK, I've applied this one, thanks!
