From: tony@atomide.com
Subject: Re: [PATCH] Alsa modularisations and support for tsc2101 3/3 (round
	2)
Date: Wed, 22 Mar 2006 08:03:59 -0800
Message-ID: <20060322160357.GD5748@atomide.com>
References: <440C9D00.7060902@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <440C9D00.7060902@cc.jyu.fi>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lamikr <lamikr@cc.jyu.fi>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* lamikr <lamikr@cc.jyu.fi> [060306 12:36]:
> OMAP Alsa Patch (3/3)
> 
> This 3/3 patch adds the tsc2101 alsa driver support for the omap-h2.
> Just like the aic23 alsa driver, the codec
> specific functionality is separated from the common alsa driver
> functionality that is in the omap-alsa.c.
> tsc2101 mixer supports currently the playback selection between
> loudspeaker and headset/handset.
> Addon of others input and targets should be possible to do afterwards.
> 
> In addition it should be possible to add later the support for the
> dynamic clocks on top of this series of patches, as discussed
> in the omap-linux mailing list.

Leaving out the following irda chunk: 
  
> @@ -255,12 +256,6 @@ static int h2_transceiver_mode(struct de
>  
>  static struct omap_irda_config h2_irda_data = {
>  	.transceiver_cap	= IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
> -	.rx_channel		= OMAP_DMA_UART3_RX,
> -	.tx_channel		= OMAP_DMA_UART3_TX,
> -	.dest_start		= UART3_THR,
> -	.src_start		= UART3_RHR,
> -	.tx_trigger		= 0,
> -	.rx_trigger		= 0,
>  };
>  
>  static struct resource h2_irda_resources[] = {

Regards,

Tony
