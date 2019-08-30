From: santosh.shilimkar@oracle.com
Subject: Re: [PATCHv3 00/10] soc: ti: add OMAP PRM driver (for reset)
Date: Fri, 30 Aug 2019 09:50:33 -0700
Message-ID: <f7d6a2fb-175c-361b-00ff-ddde67700daa@oracle.com>
References: <20190830121816.30034-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190830121816.30034-1-t-kristo@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, ssantosh@kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com, p.zabel@pengutronix.de
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 8/30/19 5:18 AM, Tero Kristo wrote:
> Hi,
> 
> V3 of the series, ended up re-sending the whole series as I squashed one
> patch from v2 and because of that the ordering has changed a bit. Changes
> in v3 contain fixes for the comments from Philipp Zabel.
> 
> - added spinlock to protect register writes
> - added own xlate function to prevent bad reset IDs to be registered
> - use mask for the valid reset detection instead of parsing reset map
> - fixed reset status bit handling
> - used iopoll macro instead of handwritten poll loop for timeouts
> - squashed patch #6 into #4 from v2 of the series
> - some other minor fixes.
> 
> This series still depends on the clk driver changes for the reset<->clk
> syncing [1].
> 
This has to wait for another merge window. It will also take care of 
dependencies landing in mainline. Will push this to linux-next as
soon as v5.4-rc1 is out. Please remind me in case you don't see it
in next after 5.4-rc1.

Regards,
Snatosh
