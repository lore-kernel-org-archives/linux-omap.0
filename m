From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH 0/4] regulator: tps65917/palmas: Cleanups and bugfixes
Date: Fri, 20 May 2016 10:01:02 +0530
Message-ID: <573E9306.5050908@ti.com>
References: <1462494592-27909-1-git-send-email-nm@ti.com>
 <572C444F.9070304@nvidia.com> <20160506171453.GX6292@sirena.org.uk>
 <572CEA22.2090300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <572CEA22.2090300@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Keerthy <j-keerthy@ti.com>, Stephen Warren <swarren@nvidia.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

+ Lee Jones

On Saturday 07 May 2016 12:31 AM, Nishanth Menon wrote:
> On 05/06/2016 12:14 PM, Mark Brown wrote:
>> On Fri, May 06, 2016 at 12:44:23PM +0530, Laxman Dewangan wrote:
>>
>>> When you are here, can you implement the dt parsing with the new method from
>>> regulator framework.
>>> Regulator FW calls callback to parse customized DT property, just need to
>>> pass the node and pointer when registering.
>>
>>> This will helps lots in cleanups and readability.
>>
>> Yes, please.
>>
> yeah, the driver has started showing it's age, it will be good to do a
> refactor.

Laxman,

I got the dt parsing with new method from regulator framework part, But
by new method do you also want to remove the dt compatible of regulators 
and let only the mfd compatible stay?

replace of_platform_populate with mfd_add_devices so that linux handles 
the drivers split up and not the device tree?

Regards,
Keerthy
>
