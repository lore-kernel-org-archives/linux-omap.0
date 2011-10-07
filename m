From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: PM: build sleep/suspend code for idle path also
	(not only suspend)
Date: Sat, 8 Oct 2011 00:00:12 +0100
Message-ID: <20111007230012.GD26805@n2100.arm.linux.org.uk>
References: <1318026686-20191-1-git-send-email-khilman@ti.com>
	<20111007223922.GC26805@n2100.arm.linux.org.uk>
	<8739f4ju2m.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <8739f4ju2m.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 07, 2011 at 03:49:37PM -0700, Kevin Hilman wrote:
> I see this in Arnd's randconfig/arm branch but not yet in
> arm-soc/for-next.   Is this being queued for v3.2?

Yes.

> This will also conflict with your devel-stable where the suspend.c is
> added.

Already sorted.
