From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [v4,1/3] wlcore/wl12xx: spi: add power operation function
Date: Fri, 29 Jan 2016 09:11:05 +0000 (UTC)
Message-ID: <20160129091105.61DD16049D@smtp.codeaurora.org>
References: <1451482533-8624-2-git-send-email-uri.mashiach@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1451482533-8624-2-git-send-email-uri.mashiach@compulab.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, linux-wireless@vger.kernel.org, Uri Mashiach <uri.mashiach@compulab.co.il>, Rob Herring <robh+dt@kernel.org>, Eliad Peller <eliad@wizery.com>, Igor Grinberg <grinberg@compulab.co.il>, bcousson@baylibre.com, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


> The power function uses a consumer regulator access to update the WiFi
> enable GPIO value.
> 
> Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
> Tested-By: Sebastian Reichel <sre@kernel.org>
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks, 2 patches applied to wireless-drivers-next.git:

4c1ce07bcf62 wlcore/wl12xx: spi: add power operation function
04654c386145 wlcore/wl12xx: spi: add device tree support

Kalle Valo
