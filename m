From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/7] omap3: make coresight register save across OFF
	modes a sysfs option
Date: Thu, 23 Sep 2010 10:52:28 -0700
Message-ID: <20100923175227.GO4211@atomide.com>
References: <13B9B4C6EF24D648824FF11BE896716203BADA0745@dlee02.ent.ti.com>
	<1280077520-7538-8-git-send-email-virtuoso@slind.org>
	<20100806123711.GI28519@shisha.kicks-ass.net>
	<20100806124726.GN23778@atomide.com> <4C8209E2.3080803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4C8209E2.3080803@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Cousson, Benoit <b-cousson@ti.com> [100904 01:49]:
> 
> These patches are still using static virtual to physical mapping in
> io.h,  shouldn't we take the opportunity of this series to fix that
> and use ioremap instead?

Hmm, well the amba device should ioremap, but we need the virt address
for sleep34xx.S also. So to me it seems like we're missing the static
ioremap entries for plat-omap/io.c for the virtual addresses.

Alexander, can you please check that and repost the remaining
three patches one more time?

Thanks,

Tony
