From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
Date: Mon, 10 Oct 2011 18:22:22 +0100
Message-ID: <20111010172222.GG3607@opensource.wolfsonmicro.com>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
	<1318263578-7407-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1318263578-7407-4-git-send-email-rnayak@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 10, 2011 at 09:49:36PM +0530, Rajendra Nayak wrote:

> +- regulator-change-voltage: boolean, Output voltage can be changed by software
> +- regulator-change-current: boolean, Output current can be chnaged by software
> +- regulator-change-mode: boolean, Operating mode can be changed by software
> +- regulator-change-status: boolean, Enable/Disable control for regulator exists
> +- regulator-change-drms: boolean, Dynamic regulator mode switching is enabled
> +- regulator-mode-fast: boolean, allow/set fast mode for the regulator
> +- regulator-mode-normal: boolean, allow/set normal mode for the regulator
> +- regulator-mode-idle: boolean, allow/set idle mode for the regulator
> +- regulator-mode-standby: boolean, allow/set standby mode for the regulator
> +- regulator-input-uV: Input voltage for regulator when supplied by another regulator
> +- regulator-always-on: boolean, regulator should never be disabled

Thinking about this I'm not sure that these should go in the device
tree, they're as much talking about what Linux is able to cope with as
they are talking about what the hardware is able to do.  Sometimes
they'll be fixed by the design but they are sometimes also restricted by
what the software is currently capable of.  DRMS is a prime example
here, it depends on how good we are at telling the API about how much
current we're using.
