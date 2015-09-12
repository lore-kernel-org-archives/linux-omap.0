From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 00/23] dmaengine/ARM: Merge the edma drivers into one
Date: Sat, 12 Sep 2015 16:51:12 +0530
Message-ID: <55F40AA8.9050706@ti.com>
References: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, vinod.koul@intel.com, linux@arm.linux.org.uk
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, olof@lixom.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday 11 September 2015 05:56 PM, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v1:
> - Convert edma platform device registration to use platform_device_register_full
> - Moved the PM callback also to the dmaengine driver - missed in v1
> - Commit message added to:
>   ARM/dmaengine: edma: Remove limitation on the number of eDMA controllers
> - New patch which reads the flag for the channel mapping support in one place
> 
> Cover letter:
> 
> with this series the edma two driver setup will be changed to have only one
> driver to support eDMA3. The legacy edma interface will be removed and eDMA can
> only be used via dmaengine API from this point on.
> In order to do the merge the following improvements has been done:
> - One driver instance per eDMA:
>  - Any number of eDMA instances are supported (both legacy and DT boot)
> - Not relying on global variables, arrays, etc
> - Code simplification and optimizations in several places
> 
> This change will also help us to do bigger changes in the eDMA driver since,
> since now we have only one driver to work with.
> 
> The series has been tested on:
> da850-evm (OMAP-L138)
> - with legacy and DT boot (both eDMA0 and eDMA1 is enabled)
> - In code swapping the eDMA instances in legacy mode to make sure the second
>   instance is handled correctly.
> 
> am335x-evmsk
> - DT boot
> 
> I think this series could go via the dmaengine tree. Changes are trivial under
> arch/arm/

I looked at the series, it looks pretty good. Thanks for getting it done!

No problem with entire series going through dmaengine. The week after
next, when I am back in office, I would like to test on DM365 as well.
But really no need to wait for it if the series is ready otherwise.

Thanks,
Sekhar
