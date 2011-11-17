From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RESEND #3 1/7] OMAP3+: PM: SR: add suspend/resume handlers
Date: Wed, 16 Nov 2011 16:02:26 -0800
Message-ID: <87vcqj62gd.fsf@ti.com>
References: <1321346765-16633-1-git-send-email-balbi@ti.com>
 <1321346765-16633-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1321346765-16633-2-git-send-email-balbi@ti.com> (Felipe Balbi's
 message of "Tue, 15 Nov 2011 10:45:59 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Felipe Balbi <balbi@ti.com> writes:

> From: Nishanth Menon <nm@ti.com>
>
> SmartReflex should be disabled while entering low power mode due to
> the following reasons:

[...]

Nishanth, in the end, didn't you decide to drop this patch?

Kevin
