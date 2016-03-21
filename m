From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 1/3] clk: ti: am335x/am4372: Add tbclk to pwm node
Date: Mon, 21 Mar 2016 11:43:18 -0700
Message-ID: <20160321184318.GS25972@codeaurora.org>
References: <1458263723-25770-1-git-send-email-fcooper@ti.com>
 <1458263723-25770-2-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1458263723-25770-2-git-send-email-fcooper@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tony@atomide.com, mturquette@baylibre.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, t-kristo@ti.com, devicetree@vger.kernel.org, thierry.reding@gmail.com, bcousson@baylibre.com, galak@codeaurora.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 03/17, Franklin S Cooper Jr wrote:
> Add tblck to the pwm nodes. This insures that the ehrpwm driver has access
> to the time-based clk.
> 
> Do not remove similar entries for ehrpwm node. Later patches will switch
> from using ehrpwm node name to pwm. But to maintain ABI compatibility we
> shouldn't remove the old entries.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Are there any plans to get off these DT_CLK entries entirely?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
