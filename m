From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 2/2] mfd: twl4030_codec: Remove unused and duplicate
 audio_mclk fields
Date: Wed, 2 Mar 2011 15:35:24 +0100
Message-ID: <20110302143523.GN16181@sortiz-mobl>
References: <1299072246-26402-1-git-send-email-ilkka.koskinen@nokia.com>
 <1299072246-26402-3-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1299072246-26402-3-git-send-email-ilkka.koskinen@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Cc: peter.ujfalusi@nokia.com, tony@atomide.com, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

Hi Ilkka,

On Wed, Mar 02, 2011 at 03:24:06PM +0200, Ilkka Koskinen wrote:
> audio_mclk can be queried from mfd driver. Therefore, it is not
> needed in twl4030_codec_audio_data or in twl4030_codec_vibra_data
> anymore.
> 
> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
