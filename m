From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] ARM: omap3evm: enable VBUS switch for EHCI tranceiver
Date: Fri, 6 Jul 2012 01:41:05 -0700
Message-ID: <20120706084105.GR1122@atomide.com>
References: <1340183693-3195-1-git-send-email-zumeng.chen@windriver.com>
 <1340183693-3195-4-git-send-email-zumeng.chen@windriver.com>
 <4FE1BC98.7050607@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4FE1BC98.7050607@mvista.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: khilman@ti.com, Zumeng Chen <zumeng.chen@windriver.com>, hvaibhav@ti.com, ajay.gupta@ti.com, jon-hunter@ti.com, mike@compulab.co.il, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Sergei Shtylyov <sshtylyov@mvista.com> [120620 05:10]:
> On 20-06-2012 13:14, Zumeng Chen wrote:
> >
> >This will set TWL4030.GPIO2 as output pin to drive EHCI tranceiver.
...

> >+	/* Enable VBUS switch by setting TWL4030.GPIO2DIR as output
> >+	 * for starting USB tranceiver
> >+	 */
> >+	if (get_omap3_evm_rev()>= OMAP3EVM_BOARD_GEN_2) {
> >+		u8 val;
> 
>    Empty line after declaration block wouldn't hurt...
> 

I'll apply these into devel-board branch with the extra line
added. Not taking the clock related patch 4/5 as that's something
Paul should queue.

Also note that the board-*.c files are being phased out with
devicetree support.

Regards,

Tony
