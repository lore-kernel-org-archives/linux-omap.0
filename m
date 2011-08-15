From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] TI814X: Add cpu type macros and detection support
Date: Mon, 15 Aug 2011 18:17:23 +0300
Message-ID: <20110815151723.GU12348@atomide.com>
References: <1312479894-22824-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1312479894-22824-1-git-send-email-hemantp@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Hemant Pedanekar <hemantp@ti.com> [110804 20:39]:
> This patch adds cpu type, macros for identification of TI814X device.
> 
> Note that following updates to common OMAP data structures are made:
> 1) struct omap_chip_id member 'oc' is updated to u32 from u16 as omap chip
> bitfield has exhausted 16 bits for CHIP_IS_XXX.
> 2) cpu_mask and RATE_IN_XXX flags have crossed 8 bit hence struct
> clksel_rate.flags, struct prcm_config.flags and cpu_mask are changed to u16 from
> u8.

We'll be getting rid of CHIP_IS usage and replace them with SoC specific
lists. So we need to wait few days and then this patch will need to get
updated a bit.

Regards,

Tony 
