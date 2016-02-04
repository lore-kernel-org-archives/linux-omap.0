From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: Re: [RFC PATCH] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
Date: Thu, 4 Feb 2016 15:14:47 -0800
Message-ID: <CAAtXAHcV-9gXcZOX8dzUOBZUwj9M=O4MAsMCJNQYAP+os-D7Tg@mail.gmail.com>
References: <1454610017-25499-1-git-send-email-grygorii.strashko@ti.com>
	<20160204224128.GG4215@xsjsorenbubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160204224128.GG4215@xsjsorenbubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, kernel@stlinux.com, tony@atomide.com, nsekhar@ti.com, Masahiro Yamada <yamada.masahiro@socionext.com>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Wei Xu <xuwei5@hisilicon.com>, linux-rockchip@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>, Liviu Dudau <liviu.dudau@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Maxime Coquelin <maxime.coquelin@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Olof Johansson <olof@lixom.net>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn>
List-Id: linux-omap@vger.kernel.org

Hi Soeren,

On Thu, Feb 4, 2016 at 2:41 PM, S=C3=B6ren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> But with this change the 'if !CPU_FREQ' becomes obsolete.
I'm confused, could you explain that statement? You don't want people
accidentally running with GT when CPU_FREQ is on, right?

Patch looks good to me, FWIW:

Acked-by: Moritz Fischer <moritz.fischer@ettus.com>

Moritz
