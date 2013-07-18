From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: dts: omap4-sdp: add dynamic pin states for
 uart3/4
Date: Thu, 18 Jul 2013 01:09:53 -0700
Message-ID: <20130718080953.GR7656@atomide.com>
References: <1374061312-25469-1-git-send-email-grygorii.strashko@ti.com>
 <1374061312-25469-4-git-send-email-grygorii.strashko@ti.com>
 <20130717153248.GI7656@atomide.com> <51E6C939.40208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51E6C939.40208-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benoit Cousson <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [130717 09:48]:
> Hi,
> 
> On 07/17/2013 06:32 PM, Tony Lindgren wrote:
> >* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [130717 04:49]:
> >>Add dynamic "active"/"idle" pin states for uart3/4 which will be applied
> >>when uart3/4 state is switched from active to idle and back by Runtime
> >>PM or during system suspend.
> >
> >This is good for testing code, but should not be merged because
> >omap4 has the iopad wake-ups available for uarts. So those can
> >be always enabled.
> 
> In this case, 2 IRQ will be received per each UART RX event - one from
> PRCM and from UART - and that's not good from PM perspective (It will
> affect on CPUIdle and CPUFreq at least).

Oh I see, that's because I accidentally left the debug code enabled
to make it easier to test the wake-up events without having to
have working off-idle. The wake flags can be kept on always for
sure.

The patch below should sort out the issue of getting wake-up interrupts
during runtime as long as you don't have DEBUG defined.

Regards,

Tony

--- a/drivers/pinctrl/pinctrl-single-omap.c
+++ b/drivers/pinctrl/pinctrl-single-omap.c
@@ -140,9 +140,17 @@ static irqreturn_t pcs_omap_handle_irq(int irq, void *data)
 		if ((val & OMAP_WAKEUP_EVENT_MASK) == OMAP_WAKEUP_EVENT_MASK)
 			generic_handle_irq(wakeirq);
 	}
-
+#ifdef DEBUG
+	/*
+	 * This enables wake-up interrupts during runtime also
+	 * causing duplicate interrupts. But it also makes debugging
+	 * the wake-up events easy as deeper idle states often are
+	 * not working for new devices while the drivers are being
+	 * developed.
+	 */
 	if (pcso->reconfigure_io_chain)
 		pcso->reconfigure_io_chain();
+#endif
 
 	return IRQ_HANDLED;
 }
