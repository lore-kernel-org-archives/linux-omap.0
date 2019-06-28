From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V4 2/3] thermal/drivers/cpu_cooling: Unregister with the
 policy
Date: Fri, 28 Jun 2019 13:57:35 +0200
Message-ID: <850b9fbb-e865-fea5-89c3-6eb26750048e@linaro.org>
References: <20190627210209.32600-1-daniel.lezcano@linaro.org>
 <20190627210209.32600-2-daniel.lezcano@linaro.org>
 <CAJZ5v0jJzCGfQFqi-S3vqs74D73MaE4f7WYF_NVnDKawNV4Wzw@mail.gmail.com>
 <cd79ffe3-4749-9135-27c4-deb4f259d702@linaro.org>
 <CAJZ5v0hPjPMLfiWMPnm59HpmTbJNXw0MDpvRwMGOUpMXYUwgRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hPjPMLfiWMPnm59HpmTbJNXw0MDpvRwMGOUpMXYUwgRw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Keerthy <j-keerthy@ti.com>, "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" <linux-pm@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list:TI BANDG
List-Id: linux-omap@vger.kernel.org

On 28/06/2019 12:03, Rafael J. Wysocki wrote:
> On Fri, Jun 28, 2019 at 11:58 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> On 28/06/2019 11:12, Rafael J. Wysocki wrote:
>>> On Thu, Jun 27, 2019 at 11:02 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> Currently the function cpufreq_cooling_register() returns a cooling
>>>> device pointer which is used back as a pointer to call the function
>>>> cpufreq_cooling_unregister(). Even if it is correct, it would make
>>>> sense to not leak the structure inside a cpufreq driver and keep the
>>>> code thermal code self-encapsulate. Moreover, that forces to add an
>>>> extra variable in each driver using this function.
>>>>
>>>> Instead of passing the cooling device to unregister, pass the policy.
>>>>
>>>> Because the cpufreq_cooling_unregister() function uses the policy to
>>>> unregister itself. The only purpose of the cooling device pointer is
>>>> to unregister the cpu cooling device.
>>>>
>>>> As there is no more need of this pointer, remove it.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>
>>> This doesn't apply for me.
>>>
>>> Care to rebase it on top of the Linus' tree?
>>
>> Sure but the patch depends on 1/3 which is in bleeding edge. Shall I
>> rebase the 3 patches on v5.2-rc6 and resend ?
> 
> You can do that.
> 
> Alternatively, you can rebase on top of my linux-next branch.

Ok, it is rebased on top of linux-next, however the conflict is coming
from the energy model patchset sent by Quentin [1][2] I used to based my
series which is not yet applied in the thermal tree.

I'm wondering if it wouldn't make sense to take Quentin's series also,
it is a long time around in the mailing list, reviewed and acked. So I
can send the two remaining patches on top of it without conflict,
otherwise we will have a conflict in the merge window.

[1] https://lkml.org/lkml/2019/5/30/794
[2] https://lkml.org/lkml/2019/6/19/190

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
