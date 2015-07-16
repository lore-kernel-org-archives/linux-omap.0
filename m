From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: hwmod: add support for lock and unlock
 hooks
Date: Thu, 16 Jul 2015 00:07:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1507160007190.32764@utopia.booyaka.com>
References: <1433928386-24891-1-git-send-email-lokeshvutla@ti.com>
 <1433928386-24891-2-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1433928386-24891-2-git-send-email-lokeshvutla@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: tony@atomide.com, t-kristo@ti.com, linux-omap@vger.kernel.org, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, 10 Jun 2015, Lokesh Vutla wrote:

> Some IP blocks like RTC, needs an additional setting for writing to its
> registers. This is to prevent any spurious writes from changing the
> register values.
> 
> This patch adds optional lock and unlock function pointers to
> the IP block's hwmod data. These unlock and lock function pointers
> are called by hwmod code before and after writing sysconfig registers.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks, queued for v4.3.

- Paul
