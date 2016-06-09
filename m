From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: DRA74x: fix DSS PLL2 addresses
Date: Thu, 9 Jun 2016 00:19:30 -0700
Message-ID: <20160609071930.GL22406@atomide.com>
References: <1463739213-31540-1-git-send-email-tomi.valkeinen@ti.com>
 <57566A4A.4020102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <57566A4A.4020102@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [160606 23:34]:
> On 20/05/16 13:13, Tomi Valkeinen wrote:
> > DSS's 'pll2_clkctrl' and 'pll2' have wrong addresses in the dra74x.dtsi
> > file. Video PLL2 has not been used so wrong addresses went unnoticed.
...
> Ping on this.

Applying into omap-for-v4.7/fixes finally thanks.

Tony
