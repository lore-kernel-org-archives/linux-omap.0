From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] ARM: OMAP4+: Have _omap4_wait_target_* check for
 valid clkctrl_offs
Date: Thu, 21 Jul 2016 23:46:32 -0700
Message-ID: <20160722064631.GX28140@atomide.com>
References: <20160712175034.743-1-d-gerlach@ti.com>
 <20160712175034.743-4-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160712175034.743-4-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Arnd Bergmann <arnd@arndb.de>, Lokesh Vutla <lokeshvutla@ti.com>, Tero Kristo <t-kristo@ti.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [160712 10:53]:
> Previously the low-level CM call internal to the
> _omap4_wait_target_ready/disable calls was responsible for checking for
> a valid clkctrl_offs. Now we must also consider the value of the
> prcm.omap4.flags because if HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET is set in
> the flags then clkctrl_offs of 0 is valid.
> 
> Let's move this check into the _omap4_wait_target_ready/disable where we
> have access to both the clkctrl_offs and the flags values and simply
> return 0 without calling the low level CM call at all, which would have
> returned 0 anyway if the clktrl_offs was zero.

This series looks OK to me to fix the RTC regression. Paul and Tero,
do you see any issues with this or care to ack?

I'm planning to s/Let's move this check/Let's add this check/ while
committing to avoid confusion.

Regards,

Tony
