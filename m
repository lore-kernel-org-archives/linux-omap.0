From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v2] arm: dts: AM43x: Add usb_otg_hs node
Date: Tue, 9 Jul 2013 10:32:19 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EB30355@DBDE04.ent.ti.com>
References: <1373361446-30050-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1373361446-30050-1-git-send-email-george.cherian@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Cherian, George" <george.cherian@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "benoit.cousson@linaro.org" <benoit.cousson@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Balbi,
 Felipe" <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi George,

On Tue, Jul 09, 2013 at 14:47:26, Cherian, George wrote:

> +		usb_otg_hs1: am4372_dwc3@48380000 {

Wouldn't "usb" a better node name ?

> +			compatible = "ti,am437x-dwc3";

Usage of wild card is discouraged per DT documentation.

Regards
Afzal
