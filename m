From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RESEND PATCH v3 03/11] ASoC: davinci-mcasp: Add
 DMA register locations to DT
Date: Thu, 10 Oct 2013 17:59:59 +0100
Message-ID: <20131010165959.GB3910@e106331-lin.cambridge.arm.com>
References: <cover.1379590035.git.jsarha@ti.com>
 <66bdda0c0b75d737d649260b9ec10f9f870c20cd.1379590036.git.jsarha@ti.com>
 <20131007214718.GA2976@kartoffel>
 <20131008004641.GV21581@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20131008004641.GV21581@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "joelf@ti.com" <joelf@ti.com>, "jsarha@ti.com" <jsarha@ti.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, Darren Etheridge <detheridge@ti.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 08, 2013 at 01:46:41AM +0100, Mark Brown wrote:
> On Mon, Oct 07, 2013 at 10:47:18PM +0100, Mark Rutland wrote:
> > On Thu, Sep 26, 2013 at 08:18:28PM +0100, Jyri Sarha wrote:
> 
> > >  - interrupts : Interrupt number for McASP
> 
> > The device also seems to be able to generate multiple interrupts -- which
> > interrupt does this actually cover?
> 
> > The driver doesn't seem to use it (by a grep of irq|interrupt). Have I missed
> > something?
> 
> No, they're not actually of much practical use to us at the minute but
> it was generally felt better to include the information and not use it
> so that if someone does come up with a use for them then the trees for
> deployed systems already have the information.

Sure, but if this device can generate multiple interrupts, we should
make it possible to describe all of them, unambiguously.

Thanks,
Mark.
