From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RESEND PATCH v3 03/11] ASoC: davinci-mcasp: Add
 DMA register locations to DT
Date: Wed, 16 Oct 2013 16:04:38 +0100
Message-ID: <20131016150438.GN19196@e106331-lin.cambridge.arm.com>
References: <cover.1379590035.git.jsarha@ti.com>
 <66bdda0c0b75d737d649260b9ec10f9f870c20cd.1379590036.git.jsarha@ti.com>
 <20131007214718.GA2976@kartoffel>
 <20131008004641.GV21581@sirena.org.uk>
 <20131010165959.GB3910@e106331-lin.cambridge.arm.com>
 <5256E417.7010403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <5256E417.7010403@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "joelf@ti.com" <joelf@ti.com>, "jsarha@ti.com" <jsarha@ti.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Darren Etheridge <detheridge@ti.com>, Mark Brown <broonie@kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 10, 2013 at 06:29:59PM +0100, Peter Ujfalusi wrote:
> On 10/10/2013 07:59 PM, Mark Rutland wrote:
> >> No, they're not actually of much practical use to us at the minute but
> >> it was generally felt better to include the information and not use it
> >> so that if someone does come up with a use for them then the trees for
> >> deployed systems already have the information.
> > 
> > Sure, but if this device can generate multiple interrupts, we should
> > make it possible to describe all of them, unambiguously.
> 
> This is why Jyri added them to the DT. They are not used by the Linux driver,
> but the HW have interrupt lines (two of them: TX and RX).

The binding only describes a single interrupt, and even if multiple
interrupts were listed, there's no way to disambiguate them (e.g.
interrupt-names).

It would be nice to remedy this.

Cheers,
Mark.
