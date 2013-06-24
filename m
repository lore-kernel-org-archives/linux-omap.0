From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 06/11] CLK: omap: move part of the machine specific
 clock header contents to driver
Date: Mon, 24 Jun 2013 10:42:04 +0300
Message-ID: <51C7F84C.5080607@ti.com>
References: <1371647942-4811-1-git-send-email-t-kristo@ti.com>
 <1371647942-4811-7-git-send-email-t-kristo@ti.com>
 <20130621073250.GO5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130621073250.GO5523@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: nm@ti.com, paul@pwsan.com, mturquette@linaro.org, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 06/21/2013 10:32 AM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [130619 06:25]:
>> Some of the clock.h contents are needed by the new OMAP clock driver,
>> including dpll_data and clk_hw_omap. Thus, move these to the generic
>> omap header file which can be accessed by the driver.
>
> Do you mean "are only needed by the new OMAP clock driver"?

Not only, it is needed by both driver and mach-omap2.

> Otherwise it sounds like this will break things for other
> omaps that don't yet have clocks configured in DT..

No it doesn't, as you can probably see, the new include/linux/clk/omap.h 
is included from clock.h also.

-Tero

>
> Regards,
>
> Tony
>
