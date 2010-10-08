From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4] ARM: Fix sparse warnings due to variables conflicts.
Date: Fri, 8 Oct 2010 10:36:15 -0700
Message-ID: <20101008173615.GJ7558@atomide.com>
References: <1286517186-29934-1-git-send-email-sourav.poddar@ti.com>
	<4CAF014D.7000909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4CAF014D.7000909@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "Shilimkar,
	Santosh" <santosh.shilimkar@ti.com>, "Poddar,
	Sourav" <sourav.poddar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan,
	Charulatha" <charu@ti.com>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [101008 04:24]:
> Poddar, Sourav had written, on 10/08/2010 12:53 AM, the following:
> >Fix the sparse warnings generated due to conflicts in variables used in readl/writel.
> >
> >
> >drivers/net/smc91x.c:312:8: warning: symbol '__v' shadows an earlier one
> >drivers/net/smc91x.c:312:8: originally declared here
> >
> >With this change, about 200 sparse warnings are fixed.
> The commit message could be a little more detailed.
> see http://marc.info/?l=linux-omap&m=128648102511076&w=2
> 
> also should $subject say ARM: io: fix namespace conflict
> to better reflect the fix? sparse warnings are just an indication IMHO

BTW, also dropping the "OMAP: Convert write/read functions to raw read/write".

That patch does not compute, and also ends up leaving files with
__raw_readw followed by writew..

Regards,

Tony
