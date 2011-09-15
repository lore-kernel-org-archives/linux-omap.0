From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] ASoC/MFD: twl4030: Fix dependencies for audio codec
Date: Thu, 15 Sep 2011 18:52:06 +0200
Message-ID: <20110915165206.GH32263@sortiz-mobl>
References: <1315214793-661-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1315214793-661-1-git-send-email-weber@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, broonie@opensource.wolfsonicro.com, tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

Hi THomas,

On Mon, Sep 05, 2011 at 11:26:33AM +0200, Thomas Weber wrote:
> The codec for Devkit8000 (TWL4030)  was not detected except
> when build with CONFIG_SND_SOC_ALL_CODECS.
> 
> twl-core.c still uses the CONFIG_TWL4030_CODEC for
> twl_has_codec().
> 
> In commit 57fe7251f5bfc4332f24479376de48a1e8ca6211
> the CONFIG_TWL4030_CODEC was renamed
> into CONFIG_MFD_TWL4030_AUDIO, thatswhy the codec
> was not detected.
> 
> This patch renames the CONFIG_ TWL4030_CODEC into
> CONFIG_MFD_TWL4030_AUDIO in twl-core.c.
> 
> Signed-off-by: Thomas Weber <weber@corscience.de>
Applied, thanks a lot.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
