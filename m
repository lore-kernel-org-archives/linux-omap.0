From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 4/7] Documentation: dt bindings: move ..usb/usb-phy.txt
 to ..phy/omap-phy.txt
Date: Thu, 12 Sep 2013 16:23:12 +0300
Message-ID: <5231C040.4040609@ti.com>
References: <1378136591-7463-1-git-send-email-kishon@ti.com>
 <1378136591-7463-5-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1378136591-7463-5-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, george.cherian@ti.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, s.nawrocki@samsung.com, pawel.moll@arm.com, swarren@wwwdotorg.org, tony@atomide.com, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, linux-usb@vger.kernel.org, balbi@ti.com, bcousson@baylibre.com, galak@codeaurora.org, grant.likely@linaro.org, rob@landley.net, linux-arm-kernel@lists.infradead.org, ian.campbell@citrix.com
List-Id: linux-omap@vger.kernel.org

On 09/02/2013 06:43 PM, Kishon Vijay Abraham I wrote:
> Since now we have a separate folder for phy, move the PHY dt binding
> documentation of OMAP to that folder.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/{usb/usb-phy.txt => phy/omap-phy.txt}        |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/{usb/usb-phy.txt => phy/omap-phy.txt} (96%)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-phy.txt b/Documentation/devicetree/bindings/phy/omap-phy.txt
> similarity index 96%
> rename from Documentation/devicetree/bindings/usb/usb-phy.txt
> rename to Documentation/devicetree/bindings/phy/omap-phy.txt
> index 36bdb17..2c485ee 100644
> --- a/Documentation/devicetree/bindings/usb/usb-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/omap-phy.txt

ti-phy.txt?

> @@ -1,4 +1,4 @@
> -USB PHY
> +OMAP PHY: DT DOCUMENTATION FOR PHYs in OMAP PLATFORM

TI PHY: PHYs in Texas Instruments SoCs

cheers,
-roger
