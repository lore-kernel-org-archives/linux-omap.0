From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] arm: omap2: timer: don't disable our timers
Date: Tue, 6 Oct 2015 01:00:29 -0700
Message-ID: <20151006080028.GI23801@atomide.com>
References: <1444092332-9011-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1444092332-9011-1-git-send-email-balbi@ti.com>
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
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [151005 17:49]:
> We actually want these devices to be created because
> we will be moving timers to drivers/clocksource and
> this will prevent them from probing.

Great. Is this safe to appy on it's own? We are not getting
system timers re-inited to the default values?

> The only situation where we want secure timers to be
> actually disabled is when we *know* we're running on
> non-GP (read: HS or EMU) chips, because the secure
> timer will NOT be available for the public world.

Yup.

Regards,

Tony
