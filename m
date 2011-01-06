From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 4/4] OMAP4: DMIC: Add DMIC codec
	platform devices
Date: Thu, 6 Jan 2011 22:25:42 +0000
Message-ID: <20110106222542.GF8408@opensource.wolfsonmicro.com>
References: <1294322439-16305-1-git-send-email-dlambert@ti.com>
	<1294322439-16305-5-git-send-email-dlambert@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1294322439-16305-5-git-send-email-dlambert@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Lambert <dlambert@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 06, 2011 at 08:00:39AM -0600, David Lambert wrote:
> This creates the DMIC codec platform devices.
> 
> The platform devices create an instance of the driver during boot up.
> 
> Signed-off-by: David Lambert <dlambert@ti.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

though:

> +static struct platform_device codec_dmic0 = {
> +	.name   = "dmic-codec",
> +	.id     = -1,
> +};

> +static inline void omap_dmic_init(void)
> +{
> +	platform_device_register(&codec_dmic0);
> +}

This feels like bad namespacing as the name is OMAP-generic but it's
actually board specific.

It might also be more sensible to just have an array of platform devices
with one entry and register that rather than bouncing through this
function as it doesn't add anything and it'll get more and more verbose
as more platform devices are added.

It may be that these things are idiomatic, though - I've not looked at
the surrounding code.
