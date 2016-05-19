From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression: next-20160518: Clk? on BeagleBoard-X15
Date: Thu, 19 May 2016 09:57:19 -0700
Message-ID: <20160519165719.GW5995@atomide.com>
References: <573DDFE6.8010209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <573DDFE6.8010209@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>, Rhyland Klein <rklein@nvidia.com>, Rob Herring <robh@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [160519 08:48]:
> I have'nt bisected yet, but the platform seems to have booted on
> next-20160517
> https://github.com/nmenon/kernel-test-logs/blob/next-20160517/omap2plus_defconfig/am57xx-evm.txt
> 
> https://github.com/nmenon/kernel-test-logs/blob/next-20160518/omap2plus_defconfig/am57xx-evm.txt

Seems to be commit ac78f9bdcf38 ("drivers/of: Fix depth when
unflattening devicetree").

Rob, you need to start playing golf or something between -rc6 and
the end of the merge window or something :)

Regards,

Tony
