From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [RFC PATCH] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
Date: Thu, 4 Feb 2016 15:39:50 -0800
Message-ID: <20160204233950.GH4215@xsjsorenbubuntu>
References: <1454610017-25499-1-git-send-email-grygorii.strashko@ti.com>
 <20160204224128.GG4215@xsjsorenbubuntu>
 <CAAtXAHcV-9gXcZOX8dzUOBZUwj9M=O4MAsMCJNQYAP+os-D7Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAtXAHcV-9gXcZOX8dzUOBZUwj9M=O4MAsMCJNQYAP+os-D7Tg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, kernel@stlinux.com, tony@atomide.com, nsekhar@ti.com, Masahiro Yamada <yamada.masahiro@socionext.com>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Wei Xu <xuwei5@hisilicon.com>, linux-rockchip@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>, Liviu Dudau <liviu.dudau@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Maxime Coquelin <maxime.coquelin@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Olof Johansson <olof@lixom.net>, Jun Nie <jun.nie@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2016-02-04 at 15:14:47 -0800, Moritz Fischer wrote:
> Hi Soeren,
>=20
> On Thu, Feb 4, 2016 at 2:41 PM, S=C3=B6ren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
>=20
> > But with this change the 'if !CPU_FREQ' becomes obsolete.
> I'm confused, could you explain that statement? You don't want people
> accidentally running with GT when CPU_FREQ is on, right?

Correct. But with this Kconfig rework you can just deselect it in
Kconfig. The generic HAVE_GT could always be selected.

	S=C3=B6ren
