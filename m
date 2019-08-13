From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH for v5.3] ARM: OMAP1: ams-delta-fiq: Fix missing irq_ack
Date: Tue, 13 Aug 2019 03:26:08 -0700
Message-ID: <20190813102608.GK52127@atomide.com>
References: <20190811084802.630-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190811084802.630-1-jmkrzyszt@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [190811 01:48]:
> Non-serio path of Amstrad Delta FIQ deferred handler depended on
> irq_ack() method provided by OMAP GPIO driver.  That method has been
> removed by commit 693de831c6e5 ("gpio: omap: remove irq_ack method").
> Remove useless code from the deferred handler and reimplement the
> missing operation inside the base FIQ handler.
> 
> Should another dependency - irq_unmask() - be ever removed from the OMAP
> GPIO driver, WARN once if missing.

Thanks applying into fixes.

Tony
