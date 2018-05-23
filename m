From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP: CLK: CLKSRC: Add suspend resume hooks
Date: Wed, 23 May 2018 14:17:17 -0700
Message-ID: <20180523211717.GW98604@atomide.com>
References: <1527013340-8036-1-git-send-email-j-keerthy@ti.com>
 <20180523184116.GS98604@atomide.com>
 <ea82b336-7e99-bc41-4b51-54fe208c5e55@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <ea82b336-7e99-bc41-4b51-54fe208c5e55@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* J, KEERTHY <j-keerthy@ti.com> [180523 20:40]:
> 
> 
> On 5/24/2018 12:11 AM, Tony Lindgren wrote:
> > * Keerthy <j-keerthy@ti.com> [180522 11:24]:
> > > Add the save and restore for clksrc as part of suspend and resume
> > > so that it saves the counter value and restores. This is needed in
> > > modes like rtc+ddr in self-refresh not doing this stalls the time.
> > Can't we now do this all in drivers/clocksource/timer-ti-*.c?
> 
> arch/arm/boot/dts/am4372.dtsi has compatible ti,omap-counter32k
> which is arch/arm/mach-omap2/timer.c compatible

Oh OK.

> IMHO clocksource suspend resume best fits under mach-omap2/timer.c
> just like clockevent has suspend/resume.

Yup you're right. Applying into omap-for-v4.18/soc thanks.
No guarantees at this point it will get merged though.

Regards,

Tony
