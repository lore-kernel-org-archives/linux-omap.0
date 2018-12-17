From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/9] ASoC/ARM: Merge the davinci and omap audio
 directories
Date: Mon, 17 Dec 2018 08:50:06 -0800
Message-ID: <20181217165006.GY6707@atomide.com>
References: <20181217122142.6652-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181217122142.6652-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, jarkko.nikula@bitmer.com, nsekhar@ti.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, jsarha@ti.com
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181217 12:20]:
> Mark, Tony, Sekhar: This series - as I mentioned - is based on next-20181210.
> Not sure what tag, branch, commit  I should base this, but I can resend v2 if
> needed.

Good to see this clean-up happen :) Best to merge this
all via the Alsa ASoC tree, it should not conflict with
anything if it already applies against next:

Acked-by: Tony Lindgren <tony@atomide.com>
