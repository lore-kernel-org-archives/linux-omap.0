From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH-next 2/4] arm: boot: dts: am4372: add ARM timers and SCU
 nodes
Date: Thu, 13 Aug 2015 01:32:15 -0700
Message-ID: <20150813083215.GY4215@atomide.com>
References: <1439409416-32673-1-git-send-email-balbi@ti.com>
 <1439409416-32673-3-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1439409416-32673-3-git-send-email-balbi@ti.com>
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

* Felipe Balbi <balbi@ti.com> [150812 13:00]:
> AM437x devices sport SCU, TWD and Global timers,
> let's add them to DTS so they have a chance to
> probe and be used by Linux.

Applying this one into omap-for-v4.3/dt-v2. Not sure
if it will get merged as we're getting close to the
merge window. The rest we can patch once Russell has
reverted the bogus SMP dependency.

Regards,

Tony
