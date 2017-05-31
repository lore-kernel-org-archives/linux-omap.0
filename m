From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am43xx-clocks: Add support for CLKOUT2
Date: Wed, 31 May 2017 10:20:32 -0700
Message-ID: <20170531172032.GI3730@atomide.com>
References: <20170524084341.16698-1-peter.ujfalusi@ti.com>
 <20170526155212.GG3717@atomide.com>
 <35f3b51b-d93f-5a65-8a63-26302d3c5815@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <35f3b51b-d93f-5a65-8a63-26302d3c5815@ti.com>
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
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [170529 01:31]:
> On 26/05/17 18:52, Tony Lindgren wrote:
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [170524 01:47]:
> > > Add the needed clock nodes for the CLKOUT2 to be usable by boards.
> > 
> > Tero, care to ack?
> 
> I can't test the actual clock itself but the patch looks fine based on TRM,
> and doesn't seem to cause any issues either so:
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

OK thanks applying into omap-for-v4.13/dt.

Tony
