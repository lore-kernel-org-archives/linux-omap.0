From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC/PATCH 11/11] arm: boot: dts: omap: add missing default status for 32k counter
Date: Wed, 30 Sep 2015 23:58:16 +0200
Message-ID: <22213826.1MtkNIZ6W3@wuerfel>
References: <1443559446-26969-1-git-send-email-balbi@ti.com> <4815825.NCBBBMgLGf@wuerfel> <20150930141209.GB31865@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150930141209.GB31865@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, daniel.lezcano@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 30 September 2015 09:12:09 Felipe Balbi wrote:
> On Wed, Sep 30, 2015 at 10:15:25AM +0200, Arnd Bergmann wrote:
> > On Tuesday 29 September 2015 15:44:06 Felipe Balbi wrote:
> > > All devices should have a default status. Ignoring
> > > the arguments if it should be 'okay' or 'disabled'
> > > by default, let's set them all the 'disabled' and
> > > have boards enable 32k counter.
> > > 
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > 
> > 
> > The patch looks good, but the description is slightly incorrect:
> > There is no reason to list "status='okay'" other than overriding
> > the 'disabled' status.
> > 
> > I'd phrase it something like:
> > 
> > "We want the use of the 32k counter to be a per-board setting,
> > so let's disable it by default in each dtsi file and override the
> > setting in the boards. Any board that does not wire up the counter
> > should leave it disabled".
> > 
> > However, if you really want all boards to provide the counter all
> > the time, I'd argue that we're better off dropping this patch. We
> > use the status="disabled" trick for anything that may or may not
> > be working based on the board design, but things that are present
> > everywhere don't need this.
> 
> okay, so here's the thing. While fiddling with the 32k counter, I noticed
> that even though there was no status listed, the thing still initializes
> fine. However, when moving 32k to drivers/clocksource and using
> CLOCKSOURCE_OF_DECLARE(), 32k would *NOT* probe unless I had an explicit
> status = "okay" in DT.

Very strange, that sounds like a bug in the clocksource probe code.
Can you check how this happens?

	Arnd
