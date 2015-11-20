From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] clocksource: arm_global_timer: fix suspend resume
Date: Fri, 20 Nov 2015 20:25:14 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1511202021330.3931@nanos>
References: <1448027861-21472-1-git-send-email-grygorii.strashko@ti.com> <564F570C.7030409@oracle.com> <564F67ED.9000905@ti.com> <CALAqxLVLQLaAq7fPwJnyOWP_dXV39Dh+QreecxSVY35wi=N0Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALAqxLVLQLaAq7fPwJnyOWP_dXV39Dh+QreecxSVY35wi=N0Og@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, santosh shilimkar <santosh.shilimkar@oracle.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, lkml <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kernel@stlinux.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 20 Nov 2015, John Stultz wrote:
> So its unlikely that the hardware both stays running through suspend,
> but also might halt in idle. That would be "unique".

The amount of creativity put into the next variants of differently
broken timers is amazing. So I wouldn't be too surprised if such a
thing actually surfaces.

Thanks,

	tglx
