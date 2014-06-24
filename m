From: Tom Rini <trini@ti.com>
Subject: Re: [PATCH v3 1/2] arm: dts: am4372: let boards access all nodes
 through phandles
Date: Tue, 24 Jun 2014 16:51:24 -0400
Message-ID: <53A9E4CC.4050409@ti.com>
References: <1403547659-24558-1-git-send-email-balbi@ti.com>
 <1403547659-24558-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1403547659-24558-2-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, linux@arm.linux.org.uk, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, r.sricharan@ti.com, robh+dt@kernel.org, galak@codeaurora.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 06/23/2014 02:20 PM, Felipe Balbi wrote:
> by providing phandles to rtc, wdt, cpu and dispc nodes,
> boards can access them to add board-specific data.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Tested-by: Tom Rini <trini@ti.com>

-- 
Tom
