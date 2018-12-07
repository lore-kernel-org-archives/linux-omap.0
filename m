From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] arm: Convert arm boot_lock to raw
Date: Fri, 7 Dec 2018 13:49:56 +0100
Message-ID: <CACRpkdYGkTrVy25nzZa9A-Kp7iNr4aMpTS_DyOEjHVmWOBbd6g@mail.gmail.com>
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-2-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181207102749.15205-2-bigeasy@linutronix.de>
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
Cc: ext Tony Lindgren <tony@atomide.com>, viresh kumar <viresh.kumar@linaro.org>, David Brown <david.brown@linaro.org>, Xu Wei <xuwei5@hisilicon.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Viresh Kumar <vireshk@kernel.org>, Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Barry Song <baohua@kernel.org>, Frank Rowand <frank.rowand@am.sony.com>, Patrice CHOTARD <patrice.chotard@st.com>, shiraz hashim <shiraz.linux.kernel@gmail.com>, =?UTF-8?Q?Andrea
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 7, 2018 at 11:28 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:

> From: Frank Rowand <frank.rowand@am.sony.com>
>
> The arm boot_lock is used by the secondary processor startup code.  The locking
> task is the idle thread, which has idle->sched_class == &idle_sched_class.
> idle_sched_class->enqueue_task == NULL, so if the idle task blocks on the
> lock, the attempt to wake it when the lock becomes available will fail:
>
> try_to_wake_up()
>    ...
>       activate_task()
>          enqueue_task()
>             p->sched_class->enqueue_task(rq, p, flags)
>
> Fix by converting boot_lock to a raw spin lock.

This makes perfect sense.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
