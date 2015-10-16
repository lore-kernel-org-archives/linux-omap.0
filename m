From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] clocksource: ti-32k: make it depend on GENERIC_CLOCKSOURCE
Date: Fri, 16 Oct 2015 14:29:58 -0700
Message-ID: <20151016212958.GG24370@atomide.com>
References: <201510170412.4siQMwFD%fengguang.wu@intel.com>
 <1445029805-13736-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1445029805-13736-1-git-send-email-balbi@ti.com>
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

* Felipe Balbi <balbi@ti.com> [151016 14:17]:
> the new ti 32k clocksource driver should depend on
> GENERIC_CLOCKSOURCE because of its reliance on
> sched_clock_register().
> 
> Let's enable that to avoid any possible build errors
> and/or warnings on randbuilds.

Thanks applying this on omap-for-v4.4/soc.

Tony
