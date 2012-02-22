From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/7] OMAP: 4430SDP: Correct fixed regulator device ID
Date: Wed, 22 Feb 2012 15:01:09 -0800
Message-ID: <20120222230109.GQ18185@atomide.com>
References: <1328868316-24749-1-git-send-email-peter.ujfalusi@ti.com>
 <1328868316-24749-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1328868316-24749-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120210 01:34]:
> The board has two fixed voltage regulator. Correct the
> device ID for the vbat, which used -1.
> Create defines for the fixed regulator IDs so when adding new
> regulators we know the next available ID to use for them.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
