From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
Date: Thu, 17 Mar 2016 14:42:37 +0100
Message-ID: <56EAB44D.7020902@linaro.org>
References: <1454610017-25499-1-git-send-email-grygorii.strashko@ti.com>
 <20160204224128.GG4215@xsjsorenbubuntu>
 <CAAtXAHcV-9gXcZOX8dzUOBZUwj9M=O4MAsMCJNQYAP+os-D7Tg@mail.gmail.com>
 <20160204233950.GH4215@xsjsorenbubuntu> <56D04D17.6030502@ti.com>
 <20160226152714.GD3173@xsjsorenbubuntu> <56DEAFB7.50105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56DEAFB7.50105@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Olof Johansson <olof@lixom.net>
Cc: Moritz Fischer <moritz.fischer@ettus.com>, kernel@stlinux.com, tony@atomide.com, nsekhar@ti.com, Masahiro Yamada <yamada.masahiro@socionext.com>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, Wei Xu <xuwei5@hisilicon.com>, linux-rockchip@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>, Liviu Dudau <liviu.dudau@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Maxime Coquelin <maxime.coquelin@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 03/08/2016 11:55 AM, Grygorii Strashko wrote:
> Yeah. Thanks
>
> I'll re-send it after 4.6-rc.
> But What I'm not fully understand is how to get it merged taking into=
 account that
> it touches few maches & clocksource :(

This is not a problem. Send it based on timers/core from the tip tree=20
and Cc the maintainers for the maches dir. As soon as they ack the=20
patches, I will merge it through my tree.

Thanks

   -- Daniel



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
