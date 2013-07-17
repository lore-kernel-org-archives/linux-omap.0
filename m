From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 0/3] ARM: OMAP2+: omap_device: add dynamic pinctrl handling
Date: Wed, 17 Jul 2013 14:57:53 +0300
Message-ID: <51E686C1.8020801@ti.com>
References: <1374061312-25469-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374061312-25469-1-git-send-email-grygorii.strashko@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Grygorii,

On 07/17/2013 02:41 PM, Grygorii Strashko wrote:
> Hi Tony, Kevin
> 
> This patch series introduces dynamic pinctrl handling in OMAP device framework
> in the same way as it was before switching to DT. 
> This allow OMAP devices driver's developers to simply add dynamic pinctrl
> handling for "default", "active", "idle", "sleep" PIN states in their drivers
> by modifying DT definitions only - no modifications in drivers code are not needed.
> 

Overall I like the idea but can we make a provision for device drivers to override
this default pin state handling?

The OMAP EHCI driver is one such special case where the wakeup mechanism is tied to pinctrl states
as it uses IO daisy chaining to implement wakeup.
So depending on whether wakeup needs to be enabled or not I must be able to chose whether
I put the pin in just "sleep" state or "sleep with wakeup" state.

cheers,
-roger
