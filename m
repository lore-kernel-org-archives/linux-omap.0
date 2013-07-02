From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH v2 5/9] wlcore: always use one-shot IRQ
Date: Tue, 2 Jul 2013 23:16:58 +0300
Message-ID: <1372796218.21065.87.camel@cumari.coelho.fi>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <1372776948-24840-6-git-send-email-coelho@ti.com>
 <20130702153229.GG7013@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130702153229.GG7013@arwen.pp.htv.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: mark.rutland@arm.com, mturquette@linaro.org, linux-doc@vger.kernel.org, tony@atomide.com, linux-wireless@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2013-07-02 at 18:32 +0300, Felipe Balbi wrote:
> On Tue, Jul 02, 2013 at 05:55:44PM +0300, Luciano Coelho wrote:
> > Since we are now using threaded IRQs without the primary handler, we
> > need to set IRQF_ONESHOT, otherwise our request will fail.
> > 
> > Signed-off-by: Luciano Coelho <coelho@ti.com>
> 
> good to see this happening, I remember we talked about this a while back
> :-)

Yeah, we talked about it and I did the patch immediately.  This is
needed because this is obviously not set automatically in the interrupts
created via device tree.


> Acked-by: Felipe Balbi <balbi@ti.com>
> 
> Still, if you call irq_set_irq_type() on board-file (since DT will do
> something similar for you anyway) then you can completely drop
> irq_flags.

Yep.

--
Luca.
