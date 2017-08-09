From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP4+: PRM: fix of_irq_get() result checks
Date: Wed, 9 Aug 2017 15:02:30 -0700
Message-ID: <20170809220229.GI3934@atomide.com>
References: <20170806151714.108596802@cogentembedded.com>
 <80dd8051-456b-2331-b847-0631d94f85b1@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <80dd8051-456b-2331-b847-0631d94f85b1@cogentembedded.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Russell King <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> [170806 08:20]:
> On 08/06/2017 06:14 PM, Sergei Shtylyov wrote:
> 
> > of_irq_get() may return 0 as well as a nagative error number on failure,
> 
>    Oops, forgot to kill comma...

I can fix that while applying.

> > (and never on success), however omap44xx_prm_late_init() regards 0 as a
> > valid IRQ -- fix this.
> > 
> > Fixes: a8f83aefcd5a ("ARM: OMAP4+: PRM: register interrupt information from DT")
> > Fixes: c5b3955828ba ("ARM: OMAP4: Fix legacy code clean-up regression")
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> [...]

Seems these both should be safe to apply into fixes-not-urgent for
v4.14 merge window as we have not seen any issues with this? Or
are there some known bugs related to this?

Regards,

Tony
