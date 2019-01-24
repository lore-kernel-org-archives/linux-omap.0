From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in Linux next with SPI pump changes
Date: Wed, 23 Jan 2019 16:11:37 -0800
Message-ID: <20190124001136.GL5720@atomide.com>
References: <20190123215642.GK5720@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190123215642.GK5720@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Sperl <kernel@martin.sperl.org>, Mark Brown <broonie@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Jon Hunter <jonathanh@nvidia.com>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [190123 21:57]:
> Hi all,
> 
> Commit 412e60373245 ("spi: core: avoid waking pump thread from spi_sync
> instead run teardown delayed") caused a PM regression in Linux next
> where a SPI device (drivers/spi/spi-omap2-mcspi.c) no longer idles
> for PM runtime.
> 
> Looks like this also breaks suspend as reported at [0].

Oh and looks like Jon already also came to the conclusion
that PM runtime is now broken at [1]. Sorry forgot to add
Jon to Cc earlier, added now.

Regards,

Tony


[0] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1899265.html
[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1901285.html
