From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/5] ARM: l2x0: Add aux control register bitfields
Date: Fri, 19 Nov 2010 18:13:22 +0000
Message-ID: <1290190402.14953.10.camel@e102109-lin.cambridge.arm.com>
References: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1290187866-26941-2-git-send-email-santosh.shilimkar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: nm@ti.com, mans@mansr.com, tony@atomide.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, 2010-11-19 at 17:31 +0000, Santosh Shilimkar wrote:
> This patch adds the PL310 Auxiliary Control Register bitfields
> so that SOC's can use these bit fields to construct the AUXCTRL
> value to be passed/programmed instead of hardcoding it.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
