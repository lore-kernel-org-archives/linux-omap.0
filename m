From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 03/23] serial: omap: don't access the platform_device
Date: Fri, 24 Aug 2012 12:07:33 -0700
Message-ID: <20120824190733.GQ11011@atomide.com>
References: <1345717983-18179-1-git-send-email-balbi@ti.com>
 <1345717983-18179-4-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1345717983-18179-4-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, alan@linux.intel.com
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [120823 03:37]:
> The driver doesn't need to know about its platform_device.
> 
> Everything the driver needs can be done through the
> struct device pointer. In case we need to use the
> OMAP-specific PM function pointers, those can make
> sure to find the device's platform_device pointer
> so they can find the struct omap_device through
> pdev->archdata field.
> 
> Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
