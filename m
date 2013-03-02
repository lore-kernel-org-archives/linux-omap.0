From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] gpio/omap: convert gpio irq domain to linear mapping
Date: Sat, 02 Mar 2013 19:39:08 +0000
Message-ID: <20130302193908.DCA413E10F3@localhost>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
 <1362158568-1624-2-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1362158568-1624-2-git-send-email-jon-hunter@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Jon Hunter <jon-hunter@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 1 Mar 2013 11:22:47 -0600, Jon Hunter <jon-hunter@ti.com> wrote:
> Currently the OMAP GPIO driver uses a legacy mapping for the GPIO IRQ
> domain. This is not necessary because we do not need to assign a
> specific interrupt number to the GPIO IRQ domain. Therefore, convert
> the OMAP GPIO driver to use a linear mapping instead.
> 
> Please note that this also allows to simplify the logic in the OMAP
> gpio_irq_handler() routine, by using irq_find_mapping() to obtain the
> virtual irq number from the GPIO bank and bank index.
> 
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Applied, thanks.

g.
