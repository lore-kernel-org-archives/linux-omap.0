From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v2 0/4] can: c_can: Add suspend/resume and pinctrl
 support
Date: Thu, 6 Sep 2012 06:09:29 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA27D69@DBDE01.ent.ti.com>
References: <1346843564-25343-1-git-send-email-anilkumar@ti.com>
 <50473D92.9000500@pengutronix.de> <504759B4.6060203@pengutronix.de>
 <20120905232609.GL1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <20120905232609.GL1303@atomide.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 06, 2012 at 04:56:10, Tony Lindgren wrote:
> * Marc Kleine-Budde <mkl@pengutronix.de> [120905 06:55]:
> > On 09/05/2012 01:54 PM, Marc Kleine-Budde wrote:
> > > On 09/05/2012 01:12 PM, AnilKumar Ch wrote:
> > >> Adds suspend/resume functionality of d_can driver along with d_can
> > >> raminit support which is required to initialize RAM while data
> > >> transmission.
> > >>
> > >> This patch series also adds pinctrl support to c_can driver. These
> > >> patches were tested on AM335x-EVM.
> > >>
> > >> This patch-series is based ontop of runtimePM patch submitted
> > >> earlier - https://patchwork.kernel.org/patch/1348081/
> > > 
> > > Looks good, I'll apply the series after Tony acks the patch 3
> > > ([PATCH RESEND 3/4] ARM: AM33XX: board-generic: Add of_dev_auxdata to
> > > pass d_can raminit).
> > 
> > I've pushed all patches to can-next/master [1]. When Tony gives his Ack,
> > I'll send David a pull request (of a tree including that Ack).
> 
> To me it looks like we can avoid the platform callbacks and the ram
> init changes to the driver by implementing right runtime PM calls
> for omap/am33xx. So NAK on few patches, and ACK on one :)
> 

Marc,

Can you please queue ACK patch for 3.7, I will submit v3 for rest of
the patches, once we found the clear way of doing RAMINIT.

Thanks
AnilKumar
