From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
Date: Wed, 27 Apr 2016 16:25:01 +0300
Message-ID: <5720BDAD.1040806@ti.com>
References: <1461684532-16848-1-git-send-email-grygorii.strashko@ti.com>
 <20160426160245.GI28464@e106497-lin.cambridge.arm.com>
 <571FC2EC.9090605@ti.com> <57209154.6050508@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <57209154.6050508-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Liviu Dudau <liviu.dudau-5wv7dgnIgG8@public.gmane.org>
Cc: kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, linux-arm-kernel-VrBV9hrLPhE@public.gmane.org, Jesper Nilsson <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>J
List-Id: linux-omap@vger.kernel.org

On 04/27/2016 01:15 PM, Robin Murphy wrote:
> On 26/04/16 20:35, Grygorii Strashko wrote:
>> On 04/26/2016 07:02 PM, Liviu Dudau wrote:
>>> On Tue, Apr 26, 2016 at 06:28:52PM +0300, Grygorii Strashko wrote:
>>>
>>> Hi Grygorii,
>>>
>>> First time I'm seeing this patch, so I have a few questions, mostly
>>> related to the commit message:
>>
>> Hm. You are in cc for RFC.
>> Sry, forgot to add link [1].
>>
>>>
>>>> This patch intended to fix following cases:
>>>> - SoC-A has ARM GT, defines DT node for ARM GT and selects
>>>> ARM_GLOBAL_TIMER statically in Kconfig file. SoC-B has ARM GT and
>>>> defines DT node for ARM GT, but do not selects ARM_GLOBAL_TIMER
>>>> statically in Kconfig file. In case of multiplatform build ARM GT will
>>>> be implicitly enabled for SoC-B.
>>>
>>> Well, SoC-B has the GT *and* the DT node, so what is the problem with
>>> enabling it for SoC-B? If there are reasons not to use the Global Timer
>>> on SoC-B, surely a better option would be to mark it in DT with 
>>> status = "disabled";
>>
>> This was rejected [2]. DT describes HW and if it is functional the 
>> status = "disabled"
>> is not good choice.
>> ARM GT can't be used as clocksource/sched_clock/clockevent when 
>> CPUFreq or
>> CPUIdle are enabled :(, and this is Linux specific functionality and
>> not HW description.
> 
> It sounds to me like the cleanest option might then be to address it 
> within the Linux-specific driver itself. How feasible would it be for 
> the GT driver to detect at runtime whether CPUfreq/idle will be used and 
> simply refuse to register as a clocksource if so? (I guess there are 
> probably horrible initialisation order issues, at least...)
> 

I do not thinK this is really possible, taking into account that
clockevent device might need to be registered very early and 
PM features can be enabled/disabled dynamically.
For example, PM is enabled by loading module for TI am437x and am335x SoCs,
but ARM GT is initialized much earlier. Before loading PM module,
it is (theoretically) possible to change clocksource and
clockevent (unbind) devices, but there is no way to change sched_clock
(or timer_delay).

-- 
regards,
-grygorii
