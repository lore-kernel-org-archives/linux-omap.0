From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/8] ARM: OMAP4: hwmod_data: Remove modulemode from
 IPU/DSP hwmods
Date: Tue, 22 Aug 2017 10:37:49 -0700
Message-ID: <20170822173749.GK6008@atomide.com>
References: <20170821234818.4755-1-s-anna@ti.com>
 <20170821234818.4755-6-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170821234818.4755-6-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Anna <s-anna@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [170821 16:48]:
>
> A shutdown sequence follows a reverse pattern
> with the processors put into reset first followed by the unmapping and
> disabling of the MMUs. Both the processors and the MMUs are present
> within a single clock domain and requires the domain be clocked and
> enabled until the last entity. The kernel crash can happen during the
> unmapping phase of the MMUs, as the hwmod layer disables the module
> during the omap_device_idle processing of the processor hwmod. This
> issue is fixed by not defining a modulemode for the IPU/DSP processors,
> which results in keeping the module in an activated state. The module
> is disabled properly during the omap_device_idle processing of the MMU
> hwmod while disabling the MMU.

I think a better way to fix this would be to make sure the module
is enabled during the unmapping phase of the MMUs. If there is no
driver left at that point to call pm_runtime_get() on the module,
do it via pdata-quirks.c using struct iommu_platform_data?

If you can't add the enable/disable around existing assert_reset/
deassert_reset, you can add a new one.

Regards,

Tony
