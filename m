From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/9] ARM/ASoC: omap-mcbsp: Move OMAP2+
	clock	parenting code to ASoC driver
Date: Mon, 13 Aug 2012 16:35:54 +0100
Message-ID: <20120813153554.GA31662@n2100.arm.linux.org.uk>
References: <1344867768-26335-1-git-send-email-peter.ujfalusi@ti.com>
 <1344867768-26335-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1344867768-26335-2-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 13, 2012 at 05:22:40PM +0300, Peter Ujfalusi wrote:
> +	fck_src = clk_get(mcbsp->dev, src);
> +	if (IS_ERR_OR_NULL(fck_src)) {

I know the same error is in the original code, but let's stop propagating
it.  IS_ERR() only here please.
