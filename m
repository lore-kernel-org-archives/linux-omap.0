From: Tony Lindgren <tony@atomide.com>
Subject: Re: [BISECTED] Nokia 770 framebuffer breakage
Date: Tue, 20 Oct 2015 07:47:07 -0700
Message-ID: <20151020144707.GA3078@atomide.com>
References: <20151019193759.GE31069@blackmetal.musicnaut.iki.fi>
 <20151019200522.GJ32536@n2100.arm.linux.org.uk>
 <20151019222413.GG31069@blackmetal.musicnaut.iki.fi>
 <20151019225033.GK32536@n2100.arm.linux.org.uk>
 <20151020085003.GA16268@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20151020085003.GA16268@blackmetal.musicnaut.iki.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Aaro Koskinen <aaro.koskinen@iki.fi> [151020 01:51]:
> 
> With newer kernels and this fix the kernel now hangs during FB
> initialization. I tried to bisect it and it seemed to point to OMAP1
> sparse IRQ changes. Unfortunately those are difficult to test because
> e.g. commit 685e2d08c54b1a1bf31bbe6562f06db089d31c7b does not seem to
> compile without some other changes...

If you need to bisect just the omap1 sparse irq changes, maybe you can
do it between v4.1-rc3..685e2d08c54b1 plus your extra patch carried.


Regards,

Tony
