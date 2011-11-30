From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V4 0/3] Introducing TI's New SoC/board AM335XEVM
Date: Wed, 30 Nov 2011 15:39:16 -0800
Message-ID: <878vmxxjrv.fsf@ti.com>
References: <1320946837-32507-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1320946837-32507-1-git-send-email-hvaibhav@ti.com> (Vaibhav
 Hiremath's message of "Thu, 10 Nov 2011 23:10:34 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vaibhav Hiremath <hvaibhav@ti.com>, Russell King <rmk@arm.linux.org.uk>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> This patch set adds support for AM335x device having
> Cortex-A8 MPU.
>
> Official website - http://www.ti.com/product/am3359
>
> AM335X is treated as another OMAP3 variant, where,
> along with existing cpu class OMAP34XX, new cpu class AM33XX is created
> and the respective type is AM335X, which is newly added device in
> the family.
> This means, cpu_is_omap34xx(), cpu_is_am33xx() and
> cpu_is_am335x() checks return success for AM335X.
>
> Also, I have validated OMAP3 boot test with this patch-series on OMAP3EVM.

After fixing the minor comment on patch 3/3, feel free to add:

Reviewed-by: Kevin Hilman <khilman@ti.com>

Also, I was surprised to discover that this booted on my (recently
arrived) BeagleBone.  It seems that u-boot (from Angstrom) is passing
the machine ID of the AM335x EVM[1], even though there is another
machine ID for the BeagleBone[2].  Is that expected?

I also see that the mach-types for this are in Russell's for-next
branch.  In order for us to merge this into Tony's master branch, we'll
need to see if Russell can pull the mach-types updates into
devel-stable.  Russell?

Kevin

[1] http://www.arm.linux.org.uk/developer/machines/list.php?id=3589
[2] http://www.arm.linux.org.uk/developer/machines/list.php?id=3808
