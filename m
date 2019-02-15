From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap soc regression fixes for v5.0-rc cycle
Date: Fri, 15 Feb 2019 13:40:36 +0100
Message-ID: <CAK8P3a1Me9rDbvv7ZTybnxMP=yUNr+aSRfdGUfevf=tXJfo2kQ@mail.gmail.com>
References: <pull-1548949376-511005@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1548949376-511005@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 31, 2019 at 4:44 PM Tony Lindgren <tony@atomide.com> wrote:
-----
> SoC fixes for omaps for v5.0-rc cycle
>
> This series contains two SoC regression fixes and one uninitialized
> variable fix:
>
> - Fix inverted nirq pin handling for omap5 that started producing
>   warnings with earlier GIC direction checks and took a while to
>   understand and confirm. Basically there are two sys_nirq pins
>   that are bypassing peripheral modules and inverted automatically
>   by the SoC and need to be handled with a custom irq_set_type()
>
> - Recent ti-sysc changes caused a regression to the pwm-omap-dmtimer
>   code where the device tree handling code for timer source clock
>   gets confused. It looks like we can remove that code eventually,
>   but for now we just drop a bogus pm_runtime_irq_safe() for the
>   timers with the related quirks caused by pm_runtime_irq_safe(),
>   and have the standard assigned-clocks and assigned-clock-parents
>   deal with setting the source clock
>
> - Fix potentially uninitialized value for display init code if
>   regmap_read() fails

Pulled into arm/fixes branch, thanks!

     Arnd
