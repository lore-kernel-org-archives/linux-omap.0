From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] ARM: OMAP2+: Fix AM335x RTC External Abort
Date: Fri, 22 Jul 2016 23:26:35 -0700
Message-ID: <20160723062635.GB28140@atomide.com>
References: <20160712175034.743-1-d-gerlach@ti.com> <5791DC3A.6070808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5791DC3A.6070808@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [160722 01:41]:
> On 12/07/16 20:50, Dave Gerlach wrote:
> > Hi,
> > With next-20160711 there is an external abort during boot on am335x
> > platforms from the RTC which is caused by commit 183e2077d007 ("ARM:
> > AM33xx: fix module_wait_ready without clkctrl register"), log is here [1].
> > The RTC hwmod is unique in that it has a clkctrl_offs of 0 which is
> > invalid normally, all other hwmods have non-zero offsets. Because of this,
> > we need to flag the hwmod so 0 actually gets used for the offset
> > instead of the just returning 0 and doing nothing.
> > 
> > This series adds a HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET flag and moves the check
> > for validity of the clkctrl_offs value to the omap_hwmod code so that we are
> > able to check both the flag and clkctrl_offs values. This code is shared by
> > all OMAP4+ platforms but shoudl have no affect for anything but RTC on
> > am335x but still boot tested on the following platforms:
> 
> Series looks good to me, so:
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

Applying these into omap-for-v4,8/soc.

Regards,

Tony
