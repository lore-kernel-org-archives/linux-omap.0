From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4 v2] ASoC: TWL4030: Driver registration
 via twl4030_codec MFD
Date: Thu, 22 Oct 2009 17:56:44 +0100
Message-ID: <20091022165643.GA28051@rakim.wolfsonmicro.main>
References: <1256207208-25010-1-git-send-email-peter.ujfalusi@nokia.com>
	<1256207208-25010-2-git-send-email-peter.ujfalusi@nokia.com>
	<1256207208-25010-3-git-send-email-peter.ujfalusi@nokia.com>
	<1256207208-25010-4-git-send-email-peter.ujfalusi@nokia.com>
	<1256207208-25010-5-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1256207208-25010-5-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: tony@atomide.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, sameo@linux.intel.com, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 22, 2009 at 01:26:48PM +0300, Peter Ujfalusi wrote:
> Change the way how the twl4030 soc codec driver is
> loaded/probed.
> Use the device probing via tlw4030_codec MFD device.

I'm OK with the series but:

> @@ -147,6 +147,7 @@ config SND_SOC_TLV320DAC33
>  	tristate
> 
>  config SND_SOC_TWL4030
> +	select TWL4030_CODEC
>  	tristate

due to Kconfig ignoring dependencies all the individual machine drivers
are going to need to select this, and SND_SOC_ALL_CODECS will need to
select it if the MFD core is enabled.  I should be able to fix this up
myself so no need to repost for that alone.
