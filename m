From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: BCM5301X: remove workaround imprecise abort
 fault handler
Date: Tue, 24 Nov 2015 16:01:02 -0800
Message-ID: <5654FA3E.6020609@gmail.com>
References: <1444905142-21500-1-git-send-email-l.stach@pengutronix.de>
 <1444905142-21500-4-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444905142-21500-4-git-send-email-l.stach@pengutronix.de>
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
Cc: Tony Lindgren <tony@atomide.com>, Hauke Mehrtens <hauke@hauke-m.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patchwork-lst@pengutronix.de
List-Id: linux-omap@vger.kernel.org

On 15/10/15 03:32, Lucas Stach wrote:
> This is not needed anymore. Handling a potentially pending imprecise external
> abort left behind by the bootloader is now done in a slightly safer way inside
> the common ARM startup code.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

Applied to soc/next, thanks!
-- 
Florian
