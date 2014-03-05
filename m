From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 0/4] clk: dt: add support for default rate/parent
Date: Wed, 5 Mar 2014 15:10:17 +0200
Message-ID: <53172239.3030705@ti.com>
References: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, mturquette@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Ping.

Mike, any feedback on this?

-Tero

On 02/13/2014 11:00 AM, Tero Kristo wrote:
> Hi,
>
> This set is a mix-match of new DT properties for generic and TI specific
> clock drivers. Basically provided for commenting purposes. The patches
> provide a way to configure clock parents / rates during boot through DT.
>
> "default-rate" : sets rate of a clock during boot, supported for any DT
> 		 clock type (through generic clock driver)
> "ti,default-parent" : selects a default parent for a multiplexer clock,
> 		      only supported for TI specific mux clock for now,
> 		      as generic mux clock does not support DT clocks
>
> Patch #4 provided as a reference how to move the default rates / parents
> from kernel code to DT.
>
> Default-rate logic in patch #2 looks somewhat complicated, as the clocks
> need to be sorted based on their parents to avoid cases where a child clock
> would set its rate first, just to be overridden by its parent changing
> rate later and resulting in incorrect rate for the child clock.
>
> If the default-rate generic property is not going to fly, it can be moved
> to TI only drivers also.
>
> -Tero
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
