From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/3] drm/i2c: tda998x: Improve
 tda998x_configure_audio() audio related pdata
Date: Sat, 6 Aug 2016 17:57:34 +0100
Message-ID: <20160806165734.GS5783@n2100.arm.linux.org.uk>
References: <cover.1470129989.git.jsarha@ti.com>
 <5adcd94104080abcd5b072a5d6a85b85c5ea0584.1470129989.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <5adcd94104080abcd5b072a5d6a85b85c5ea0584.1470129989.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, airlied@linux.ie, tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, broonie@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 02, 2016 at 03:05:07PM +0300, Jyri Sarha wrote:
> @@ -787,19 +792,13 @@ tda998x_configure_audio(struct tda998x_priv *priv,
>  	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_CTS);
>  
>  	/* Write the channel status */
> -	buf[0] = IEC958_AES0_CON_NOT_COPYRIGHT;
> -	buf[1] = 0x00;
> -	buf[2] = IEC958_AES3_CON_FS_NOTID;
> -	buf[3] = IEC958_AES4_CON_ORIGFS_NOTID |
> -			IEC958_AES4_CON_MAX_WORDLEN_24;
> -	reg_write_range(priv, REG_CH_STAT_B(0), buf, 4);
> +	reg_write_range(priv, REG_CH_STAT_B(0), params->status, 4);

Another couple of points here:

1. I think we should only write the channel status if I2S mode is
selected - channel status won't be used on SPDIF mode as SPDIF
supplies its own channel status.

2. I think we should continue writing all the channel status in a
single I2C transaction, and not breaking it into several different
transactions to cater for the odd register order.  I don't have
any direct evidence that one way is better than the other in terms
of atomicity of the update, but I think having it as a single
transaction stands a better chance of the chip atomically updating
the channel status.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
