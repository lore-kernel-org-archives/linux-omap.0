From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 0/5] gpio/omap: 2nd batch of updates for v3.10
Date: Fri, 05 Apr 2013 10:56:03 -0700
Message-ID: <87hajklv4c.fsf@linaro.org>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1365106576-31816-1-git-send-email-jon-hunter@ti.com> (Jon
 Hunter's message of "Thu, 4 Apr 2013 15:16:11 -0500")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Jon Hunter <jon-hunter@ti.com> writes:

> Main change is ensuring that the state of a gpio bank is restored when
> booting with device-tree. The rest of the patches are clean-ups and one
> optimisation.
>
> The patch modifying the *.dtsi files should go via Benoit Cousson's
> for_3.10/dts branch [1] as it is dependent on changes in his branch but
> I have included here for completeness.
>
> Testing includes:
> - Boot testing on OMAP5912 OSK, OMAP2420 H4, OMAP3430 SDP, OMAP4430 SDP
>   and AM335x EVM.
> - Verified that GPIO interrupts are working on OMAP5912 OSK, OMAP2420 H4,
>   OMAP3430 SDP and OMAP4430 SDP by making sure networking was working
>   correctly as these boards use a GPIO with the ethernet chips. Also
>   checked /proc/interrupts to ensure GPIO interrupt counts are
>   incrementing as expected.
>
> [1] http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git
>
> Jon Hunter (4):
>   gpio/omap: free irq domain in probe() failure paths
>   gpio/omap: optimise interrupt service routine
>   gpio/omap: force restore if context loss is not detectable
>   ARM: dts: OMAP2+: Identify GPIO banks that are always powered
>
> Tarun Kanti DebBarma (1):
>   gpio/omap: remove extra context restores in *_runtime_resume()

For the gpio/omap patches

Reviewed-by: Kevin Hilman <khilman@linaro.org>
