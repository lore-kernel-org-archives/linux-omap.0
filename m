From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/4] can: c_can: Add suspend/resume and pinctrl
 support
Date: Wed, 5 Sep 2012 16:26:10 -0700
Message-ID: <20120905232609.GL1303@atomide.com>
References: <1346843564-25343-1-git-send-email-anilkumar@ti.com>
 <50473D92.9000500@pengutronix.de>
 <504759B4.6060203@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <504759B4.6060203@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: AnilKumar Ch <anilkumar@ti.com>, wg@grandegger.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Marc Kleine-Budde <mkl@pengutronix.de> [120905 06:55]:
> On 09/05/2012 01:54 PM, Marc Kleine-Budde wrote:
> > On 09/05/2012 01:12 PM, AnilKumar Ch wrote:
> >> Adds suspend/resume functionality of d_can driver along with d_can
> >> raminit support which is required to initialize RAM while data
> >> transmission.
> >>
> >> This patch series also adds pinctrl support to c_can driver. These
> >> patches were tested on AM335x-EVM.
> >>
> >> This patch-series is based ontop of runtimePM patch submitted
> >> earlier - https://patchwork.kernel.org/patch/1348081/
> > 
> > Looks good, I'll apply the series after Tony acks the patch 3
> > ([PATCH RESEND 3/4] ARM: AM33XX: board-generic: Add of_dev_auxdata to
> > pass d_can raminit).
> 
> I've pushed all patches to can-next/master [1]. When Tony gives his Ack,
> I'll send David a pull request (of a tree including that Ack).

To me it looks like we can avoid the platform callbacks and the ram
init changes to the driver by implementing right runtime PM calls
for omap/am33xx. So NAK on few patches, and ACK on one :)

Regards,

Tony

> [1] https://gitorious.org/linux-can/linux-can-next
