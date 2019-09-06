From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCHv4 01/10] dt-bindings: omap: add new binding for PRM
 instances
Date: Fri, 6 Sep 2019 13:56:58 +0100
Message-ID: <CAL_JsqLHTsEz6RJSi3rZ9AKyTBc00abyAxqwG8B9zAqL6cnv+w@mail.gmail.com>
References: <20190830121816.30034-2-t-kristo@ti.com>
 <20190906103558.17694-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190906103558.17694-1-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Philipp Zabel <p.zabel@pengutronix.de>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 6, 2019 at 11:36 AM Tero Kristo <t-kristo@ti.com> wrote:
>
> Add new binding for OMAP PRM (Power and Reset Manager) instances. Each
> of these will act as a power domain controller and potentially as a reset
> provider.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> v4:
> - renamed nodes as power-controller
> - added documentation about hierarchy
>
>  .../devicetree/bindings/arm/omap/prm-inst.txt | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/prm-inst.txt

Reviewed-by: Rob Herring <robh@kernel.org>
