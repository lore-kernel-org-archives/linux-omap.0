From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCHv3 01/10] dt-bindings: omap: add new binding for PRM
 instances
Date: Tue, 03 Sep 2019 15:25:29 +0200
Message-ID: <1567517129.5229.9.camel@pengutronix.de>
References: <20190830121816.30034-1-t-kristo@ti.com>
 <20190830121816.30034-2-t-kristo@ti.com> <20190902042631.GA22055@bogus>
 <e8d700cd-8f3c-5cea-a022-b20a595fc1e1@ti.com>
 <CAL_Jsq+AJj1bgOQYG=c86A5HC_g2UZph387oVEKZyP4M18kURw@mail.gmail.com>
 <7c2c8a4d-d24e-ceec-afc1-04cdc4d5d952@ti.com>
 <20190903131632.GL52127@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190903131632.GL52127@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Rob Herring <robh@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Tue, 2019-09-03 at 06:16 -0700, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [190903 08:15]:
> > On 03/09/2019 11:10, Rob Herring wrote:
> > > I prefer that bindings be complete as possible even if driver support
> > > is not there yet. Adding power domain support may only mean adding
> > > '#power-domain-cells'.
> > > 
> > > The location is fine then.
> > 
> > Yeah, I assume just adding power-domain-cells should be enough. I am not too
> > sure before I start trying this out though so did not want to add it yet.
> 
> Should we call the device tree node name power-controller instead of
> reset controller though? Most of the PRM instances do not have a
> separate rstctrl reset control functionality.
> 
> Anybody got better any better naming in mind?

power-controller seems fine to me, that is their primary function.

regards
Philipp
