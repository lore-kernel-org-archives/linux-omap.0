From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am57xx-idk: tpic2810 is on I2C bus, not SPI
Date: Tue, 28 Feb 2017 08:37:34 -0800
Message-ID: <20170228163733.GT21809@atomide.com>
References: <f884c250c4142ef44ec0c770aab277803f1f5da3.1487171304.git.nsekhar@ti.com>
 <504d1a9f-8c89-43b2-9a49-f130a21c50fd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <504d1a9f-8c89-43b2-9a49-f130a21c50fd@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [170215 07:43]:
> On 02/15/2017 09:12 AM, Sekhar Nori wrote:
> > commit 50e95b6b854c ("ARM: dts: am57xx-idk: Add Industrial
> > output support") added the TPIC2810 device-tree node under
> > SPI bus instead of I2C1.
> > 
> 
> Well that's odd, looks like git could get confused by the lack of
> context around the node during rebases. Anyway,
> 
> Acked-by: Andrew F. Davis <afd@ti.com>

Applying into omap-for-v4.11/fixes thanks.

Tony
