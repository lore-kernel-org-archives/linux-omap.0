From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [RESEND PATCH v3 10/11] ARM/dts: am33xx: mcasp:
 Add new dma register location to reg-property
Date: Tue, 8 Oct 2013 14:35:32 +0300
Message-ID: <5253EE04.6040704@ti.com>
References: <cover.1379590035.git.jsarha@ti.com>
 <c7a2c57b695804f52927ed5fd865bc8a9988335a.1379590036.git.jsarha@ti.com>
 <20131007220030.GD2976@kartoffel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20131007220030.GD2976@kartoffel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "joelf@ti.com" <joelf@ti.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, Darren Etheridge <detheridge@ti.com>, "broonie@kernel.org" <broonie@kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 10/08/2013 01:00 AM, Mark Rutland wrote:
> For consistency with reg and other composite value properties, I'd prefer that
> each entry in the list were individually bracketed:
>
> 			dmas = <&edma 8>,
> 			       <&edma 9>;
>

Makes sense. I'll do that. Thanks!

> It would also be nice if interrupts were written this way.

I'll change that too.

Cheers,
Jyri
