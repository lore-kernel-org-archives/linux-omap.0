From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] Input: tsc2005 - convert to regmap
Date: Wed, 15 Jul 2015 23:34:23 -0700
Message-ID: <20150716063423.GA5690@dtor-ws>
References: <1436962408-5206-1-git-send-email-sre@kernel.org>
 <1436962408-5206-3-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436962408-5206-3-git-send-email-sre@kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-input@vger.kernel.org, Michael Welling <mwelling@emacinc.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 15, 2015 at 02:13:26PM +0200, Sebastian Reichel wrote:
> -static int tsc2005_write(struct tsc2005 *ts, u8 reg, u16 value)
> -{
> -	u32 tx = ((reg | TSC2005_REG_PND0) << 16) | value;
> -	struct spi_transfer xfer = {
> -		.tx_buf		= &tx,
> -		.len		= 4,
> -		.bits_per_word	= 24,
> -	};

I wonder why the original code used 24 bit-sized-words for transfers...

-- 
Dmitry
