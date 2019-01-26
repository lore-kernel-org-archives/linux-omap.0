From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/3] clocksource: timer-ti-dm: Fix pwm dmtimer usage of
 fck reparenting
Date: Sat, 26 Jan 2019 20:30:47 +0100
Message-ID: <99532D7E-DCF3-4ECF-B65D-62C3C60E188F@goldelico.com>
References: <20190122175717.13428-1-tony@atomide.com>
 <20190122175717.13428-2-tony@atomide.com> <20190126194044.2fad4427@aktux>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190126194044.2fad4427@aktux>
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
Cc: Ladislav Michl <ladis@linux-mips.org>, Keerthy <j-keerthy@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Pavel Machek <pavel@ucw.cz>, Andreas Kemnade <andreas@kemnade.info>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


> Am 26.01.2019 um 19:40 schrieb Andreas Kemnade <andreas@kemnade.info>:
> 
> On Tue, 22 Jan 2019 09:57:15 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
>> Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
>> them with ti-sysc") moved some omap4 timers to probe with ti-sysc
>> interconnect target module. Turns out this broke pwm-omap-dmtimer
>> where we now try to reparent the clock to itself with the following:
>> 
>> omap_dm_timer_of_set_source: failed to set parent
>> 
>> With ti-sysc, we can now configure the clock sources in the dts
>> with assigned-clocks and assigned-clock-parents. So we should be able
>> to remove omap_dm_timer_of_set_source with clean-up patches later on.
>> But for now, let's just fix it first by checking if parent and fck
>> are the same and bail out of so.
>> 
> together with 2/3 it fixes things on pyra
> 
> Tested-By: Andreas Kemnade <andreas@kemnade.info>

Tested-By: H. Nikolaus Schaller <hns@goldelico.com>
