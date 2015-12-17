From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: OMAP1/2+: DO not create omap-pcm-audio device
Date: Thu, 17 Dec 2015 10:36:28 -0800
Message-ID: <20151217183627.GA23396@atomide.com>
References: <1449838220-24309-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449838220-24309-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [151211 04:51]:
> Hi,
> 
> The ASoC omap-pcm has been converted to be non platform device a long time ago,
> so it is no longer needed to create the device for it since there will be no
> driver to be loaded for it.

OK, applying into omap-for-v4.5/soc-v2 thanks.

Tony
