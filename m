From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] ARM: dts: am43xx-clocks: Add support for CLKOUT2
Date: Mon, 29 May 2017 11:27:46 +0300
Message-ID: <35f3b51b-d93f-5a65-8a63-26302d3c5815@ti.com>
References: <20170524084341.16698-1-peter.ujfalusi@ti.com>
 <20170526155212.GG3717@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170526155212.GG3717@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

On 26/05/17 18:52, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [170524 01:47]:
>> Add the needed clock nodes for the CLKOUT2 to be usable by boards.
>
> Tero, care to ack?

I can't test the actual clock itself but the patch looks fine based on 
TRM, and doesn't seem to cause any issues either so:

Acked-by: Tero Kristo <t-kristo@ti.com>
