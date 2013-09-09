From: Tom Rini <trini@ti.com>
Subject: Re: [PATCHv3] ARM: OMAP2+: am335x-bone*: add DT for BeagleBone Black
Date: Mon, 9 Sep 2013 09:19:02 -0400
Message-ID: <522DCAC6.8080705@ti.com>
References: <1378638746-10627-1-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1378638746-10627-1-git-send-email-koen@dominion.thruhere.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, swarren@wwwdotorg.org, tony@atomide.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, bcousson@baylibre.com, olof@lixom.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09/08/2013 07:12 AM, Koen Kooi wrote:
> The BeagleBone Black is basically a regular BeagleBone with eMMC and HDMI added,
> so create a common dtsi both can use.
> 
> IMPORTANT: booting the existing am335x-bone.dts will blow up the HDMI transceiver 
> after a dozen boots with an uSD card inserted because LDO will be at 3.3V instead
> of 1.8. 
> 
> MMC support for AM335x still isn't in, so only the LDO change has been added.
> 
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>

Grabbed my beaglebone white and black and tested them both on top of
e5c832d (top of Linus' tree atm), came up with a ramdisk.

Tested-by: Tom Rini <trini@ti.com>

-- 
Tom
