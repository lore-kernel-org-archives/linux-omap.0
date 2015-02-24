From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arm: boot: dts: am437x-idk: fix TPS62362 i2c bus
Date: Tue, 24 Feb 2015 10:02:39 -0800
Message-ID: <20150224180239.GD11056@atomide.com>
References: <1424369035-26423-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1424369035-26423-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [150219 10:08]:
> As it turns out, tps62362 is actually on I2C bus0,
> not bus1. This has gone unnoticed because Linux
> doesn't use (as of now) that regulator at all, it's
> setup by the bootloader and left as is.
> 
> While at that, also add missing reg property for
> our regulator.

Applying both into omap-for-v4.0/fixes thanks.

Tony
