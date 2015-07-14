From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: dts: dra7: arch timer sits in always-on power domain
Date: Mon, 13 Jul 2015 21:49:45 -0700
Message-ID: <20150714044944.GA11198@atomide.com>
References: <1436820101-2172-1-git-send-email-balbi@ti.com>
 <CAGo_u6oM2rtdvLp3deDsxJJWpJ6YZJ5b02m1qDdxhEjUH_69dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAGo_u6oM2rtdvLp3deDsxJJWpJ6YZJ5b02m1qDdxhEjUH_69dg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [150713 13:56]:
> On Mon, Jul 13, 2015 at 3:41 PM, Felipe Balbi <balbi@ti.com> wrote:
> > According to DRA7x TRM section 4.3.5 Realtime Counter (Master Counter),
> > the realtime counter sits in the Wakeup Always-On Power domain.
> > Furthermore, the counter will automatically switch the 32K clock source
> > when MPU goes into standby and automatically switch back to SYS_CLK or
> > ABE_LP when MPU goes out of standby.

That's good to hear. Is that the case also for 5432?

Regards,

Tony
