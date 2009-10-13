From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/2] arm: a driver for on-chip ETM and ETB
Date: Tue, 13 Oct 2009 18:47:22 +0100
Message-ID: <20091013174722.GB1134@n2100.arm.linux.org.uk>
References: <1255453611-16119-1-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1255453611-16119-1-git-send-email-virtuoso@slind.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexander Shishkin <virtuoso@slind.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 13, 2009 at 08:06:50PM +0300, Alexander Shishkin wrote:
> +	emu_clk = *(struct clk **)pdev->dev.platform_data;
> +	if (emu_clk)
> +		clk_enable(emu_clk);
> +

Definitely no way this is going to be acceptable.  Never EVER pass clk
pointers around like this.

And you've ignored the comments about it being a platform driver.

Sorry, but the answer to this patch is a firm NAK.

Please make it an AMBA primecell driver.  Also make it follow the clk
API correctly, and claim the three clocks for that primecell *only*.
