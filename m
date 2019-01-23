From: Tony Lindgren <tony@atomide.com>
Subject: Regression in Linux next with SPI pump changes
Date: Wed, 23 Jan 2019 13:56:42 -0800
Message-ID: <20190123215642.GK5720@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Sperl <kernel@martin.sperl.org>, Mark Brown <broonie@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Commit 412e60373245 ("spi: core: avoid waking pump thread from spi_sync
instead run teardown delayed") caused a PM regression in Linux next
where a SPI device (drivers/spi/spi-omap2-mcspi.c) no longer idles
for PM runtime.

Looks like this also breaks suspend as reported at [0].

Regards,

Tony

[0] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1899265.html
