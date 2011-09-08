From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap: convert per-board modules to
	platform drivers
Date: Thu, 8 Sep 2011 09:13:42 -0700
Message-ID: <20110908161341.GA3098@opensource.wolfsonmicro.com>
References: <1315494354-17597-1-git-send-email-mans.rullgard@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1315494354-17597-1-git-send-email-mans.rullgard@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mans Rullgard <mans.rullgard@linaro.org>
Cc: alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linaro-dev@lists.linaro.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 08, 2011 at 04:05:53PM +0100, Mans Rullgard wrote:

> +static struct platform_device omap_soc_audio = {
> +	.name	= "omap-soc-audio",
> +	.id	= -1,
> +};
> +

This isn't really accomplishing anything as you're using the same device
name for all boards, it's essentially the same thing as soc-audio just
an OMAP version of that device.  Each machine driver should be a
separate platform driver.
