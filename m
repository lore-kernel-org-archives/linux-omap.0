From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/9] mmc: hsmmc_omap: include types.h and provide header
 inclusion guard
Date: Wed, 14 Feb 2018 09:50:29 -0800
Message-ID: <20180214175029.GP6364@atomide.com>
References: <20180213013243.8378-1-s-anna@ti.com>
 <20180213013243.8378-3-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180213013243.8378-3-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Anna <s-anna@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [180213 01:33]:
> The hsmmc-omap platform data header file uses some u8/u16/u32 types,
> so include the linux types.h header file so that it is self-contained.
> The lack of this header caused some build errors while cleaning up some
> other header files from various omap_hwmod data files.
> 
> While at this, also add the missing header inclusion guard.
> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> Hi Ulf,
> 
> This patch is part of a hwmod cleanup series, and is needed before I
> can do the cleanup in those files. So prefer to have this patch go
> through Tony as part of the series.

No need for this, I'll post a patch that includes types.h
directly in the calling code.

Regards,

Tony
