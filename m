From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v2] ARM: dts: am33xx: Move the cppi41dma node so it's
 probed early
Date: Mon, 12 May 2014 11:02:26 -0300
Message-ID: <20140512140226.GA20360@arch.cereza>
References: <1398373881-23369-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <53705548.7020400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <53705548.7020400@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: George Cherian <george.cherian@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 12 May 10:29 AM, George Cherian wrote:
> On 4/25/2014 2:41 AM, Ezequiel Garcia wrote:
> >The DMA controller is needed for the USB controller to be correctly
> >registered. Therefore, if the DMA node is located at the end an unecessary
> >probe deferral is produced systematically.
> >
> >This is easily fixed by moving the node at the beggining of the child list,
> >so it's probed first.
> >
> >Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Acked-by: George Cherian <george.cherian@ti.com>

Actually, I'm having second thoughts about this patch. I think it's really
fragile to depend on the devicetree ordering. Instead, I've prepared a patch
that forces the driver to probe the nodes in strict order, based in the
compatible string.
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
