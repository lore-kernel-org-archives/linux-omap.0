From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3] ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock
	control detection
Date: Fri, 07 Oct 2011 13:40:26 -0700
Message-ID: <87y5wwk01x.fsf@ti.com>
References: <alpine.DEB.2.00.1110061310390.4611@utopia.booyaka.com>
	<CAGDS+nno3=sDDwdF6Ew6qG-8mN9bCeawCpho+AJo=jE9QVk0ag@mail.gmail.com>
	<alpine.DEB.2.00.1110061346570.4611@utopia.booyaka.com>
	<20111006222912.GA27281@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1110061716150.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1110061716150.4611@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 6 Oct 2011 17:18:45 -0600 (MDT)")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Steve Sakoman <sakoman@gmail.com>, dhylands@gmail.com, linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> The way that we detect which OMAP3 chips support I/O wakeup and
> software I/O chain clock control is broken.
>
> Currently, I/O wakeup is marked as present for all OMAP3 SoCs other
> than the AM3505/3517.  The TI81xx family of SoCs are at present
> considered to be OMAP3 SoCs, but don't support I/O wakeup.  To resolve
> this, convert the existing blacklist approach to an explicit,
> whitelist support, in which only SoCs which are known to support I/O
> wakeup are listed.  (At present, this only includes OMAP34xx,
> OMAP3503, OMAP3515, OMAP3525, OMAP3530, and OMAP36xx.)
>
> Also, the current code incorrectly detects the presence of a
> software-controllable I/O chain clock on several chips that don't
> support it.  This results in writes to reserved bitfields, unnecessary
> delays, and console messages on kernels running on those chips:
>
>     http://www.spinics.net/lists/linux-omap/msg58735.html
>
> Convert this test to a feature test with a chip-by-chip whitelist.
>
> Thanks to Dave Hylands <dhylands@gmail.com> for reporting this problem
> and doing some testing to help isolate the cause.  Thanks to Steve
> Sakoman <sakoman@gmail.com> for catching a bug in the first version of
> this patch.  Thanks to Russell King <linux@arm.linux.org.uk> for
> comments.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Dave Hylands <dhylands@gmail.com>
> Cc: Steve Sakoman <sakoman@gmail.com>
> Tested-by: Steve Sakoman <sakoman@gmail.com>
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> ---
>
> This version incorporates some comments from RMK - an unnecessary 
> set of parentheses are removed and a two-part error message string is 
> joined.  Also, the printk(KERN_ERR has been converted into a pr_err(. 

OK, looks like we made some parallel changes.

Dropping my version and will queue this one (branch: for_3.2/pm-cleanup-2)

Kevin
