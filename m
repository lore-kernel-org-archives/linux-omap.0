From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 REPOST 4/4] ARM: OMAP2+: dmtimer: cleanup fclk usage
Date: Fri, 6 Jul 2012 01:18:40 -0700
Message-ID: <20120706081840.GM1122@atomide.com>
References: <1341492059-5544-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1341492059-5544-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [120705 05:45]:
> With omap_hwmod_get_main_clk() now available, this can be passed to
> clk_get() to extract the fclk and thus avoid construction of fclk name.
> Corrected the timer fck name mis-match between clock44xx_data.c and
> omap_hwmod_44xx_data.c. For other platforms this is already taken care.

Thanks applying into cleanup-part2 branch.

Tony
