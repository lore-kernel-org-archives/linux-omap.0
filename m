From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 2/8] soc: ti: add initial PRM driver with reset control
 support
Date: Fri, 23 Aug 2019 10:50:05 +0200
Message-ID: <1566550205.3023.4.camel@pengutronix.de>
References: <1565164139-21886-1-git-send-email-t-kristo@ti.com>
 <1565164139-21886-3-git-send-email-t-kristo@ti.com>
 <3b76f0e0-7530-e7b5-09df-2de9956f30ee@ti.com>
 <59709a2d-f13a-bd55-8aba-864c1cf2f19e@ti.com>
 <9372957c-9ab9-b0dd-fe07-815eb2cb2f16@ti.com>
 <0f335aec-bfdf-345a-8dfb-dad70aef1af6@ti.com>
 <a4196b73-63a0-f9d8-1c43-e6c4d1c1d6a4@ti.com>
 <1566400237.4193.15.camel@pengutronix.de>
 <5e82199f-2f75-ee05-ba65-1595d0526572@ti.com>
 <e75eed22-1bed-4c8a-930d-e05890d58c47@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e75eed22-1bed-4c8a-930d-e05890d58c47@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, Suman Anna <s-anna@ti.com>, Keerthy <j-keerthy@ti.com>, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, robh+dt@kernel.org
Cc: tony@atomide.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 2019-08-21 at 21:15 +0300, Tero Kristo wrote:
> On 21.8.2019 18.45, Suman Anna wrote:
> > On 8/21/19 10:10 AM, Philipp Zabel wrote:
[...]
> > > In general, assuming the device tree contains no errors, this should not
> > > matter much, but I think it is nice if the reset driver, even with a
> > > misconfigured device tree, can't write into arbitrary bit fields.
> > 
> > Tero,
> > Can you add a check for this if possible?
> 
> Well, I can enforce the usage of reset bit mapping, which I have already 
> implemented for some SoCs like am33xx. If the specific ID is not found, 
> I can bail out. So, basically in this example requesting reset at index 
> 3 would succeed, but it would fail for any other ID; this would be 
> direct HW bit mapping.

That should be fine.

regards
Philipp
