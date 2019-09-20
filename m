From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv6 01/10] dt-bindings: omap: add new binding for PRM
 instances
Date: Fri, 20 Sep 2019 07:26:14 -0700
Message-ID: <20190920142614.GQ5610@atomide.com>
References: <20190917174817.GA27938@bogus>
 <20190919123001.23081-1-t-kristo@ti.com>
 <CAL_Jsq+x93K9=L4s6ZdmsDb__==kP36WbM_WY1pB-_QNPOhsGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+x93K9=L4s6ZdmsDb__==kP36WbM_WY1pB-_QNPOhsGw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh+dt@kernel.org> [190919 19:55]:
> On Thu, Sep 19, 2019 at 7:30 AM Tero Kristo <t-kristo@ti.com> wrote:
> >
> > Add new binding for OMAP PRM (Power and Reset Manager) instances. Each
> > of these will act as a power domain controller and potentially as a reset
> > provider.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> > v6: added common compatible as per request from Tony Lindgren. This is
> >     to simplify the support code in patch #10 of the series slightly
> >
> >  .../devicetree/bindings/arm/omap/prm-inst.txt | 30 +++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/omap/prm-inst.txt
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Looks good to me too:

Reviewed-by: Tony Lindgren <tony@atomide.com>
