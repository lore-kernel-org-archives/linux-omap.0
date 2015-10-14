From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH 4/4] ARM: BCM5301X: remove workaround imprecise abort
 fault handler
Date: Wed, 14 Oct 2015 23:48:51 +0200
Message-ID: <561ECDC3.3070502@hauke-m.de>
References: <1444834113-18122-1-git-send-email-l.stach@pengutronix.de>
 <1444834113-18122-5-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444834113-18122-5-git-send-email-l.stach@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>, Tony Lindgren <tony@atomide.com>, patchwork-lst@pengutronix.de, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 10/14/2015 04:48 PM, Lucas Stach wrote:
> This is not needed anymore. Handling a potentially pending imprecise external
> abort left behind by the bootloader is now done in a slightly safer way inside
> the common ARM startup code.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

I tested this on my board and this fixes the problem.

Hauke
