From: Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH] Fix USB host on 1510/5910?
Date: Thu, 30 Mar 2006 19:02:21 +0100
Message-ID: <20060330180220.GH26949@earth.li>
References: <20060328164403.GL26949@earth.li> <20060328190519.GS26949@earth.li>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FxlYARId5dseejUu"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060328190519.GS26949@earth.li>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--FxlYARId5dseejUu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 28, 2006 at 08:05:19PM +0100, Jonathan McDowell wrote:
> I'd still like to know if anyone's having success with a 1510/5910 and
> latest git though, as I've had someone else tell me they were seeing
> similar problems on a platform that wasn't the E3 (unfortunately it
> was on IRC and I don't have their details. :( ).

ladis, I think this was you. Does the attached help at all, if you're
still having problems? It sorts things out for me on the E3 with latest
git; the OMAP5910 datasheet says that the lb clock needs enabled for USB
to work, so it seems reasonable that this is required.

J.

-- 
noodles is not pasta

--FxlYARId5dseejUu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="omap-git-usb-fix.diff"

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 6178f04..664c3e2 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -80,8 +80,15 @@ static struct omap_uart_config ams_delta
 	.enabled_uarts = 1,
 };
 
+static struct omap_usb_config ams_delta_usb_config __initdata = {
+	.register_host	= 1,
+	.hmc_mode	= 16,
+	.pins[0]	= 2,
+};
+
 static struct omap_board_config_kernel ams_delta_config[] = {
 	{ OMAP_TAG_UART,	&ams_delta_uart_config },
+	{ OMAP_TAG_USB,		&ams_delta_usb_config },
 };
 
 static void __init ams_delta_init(void)
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index d9207d8..ced5b2e 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -353,7 +353,11 @@ int usb_hcd_omap_probe (const struct hc_
 	if (IS_ERR(usb_host_ck))
 		return PTR_ERR(usb_host_ck);
 
-	usb_dc_ck = clk_get(0, "usb_dc_ck");
+	if (!cpu_is_omap1510())
+		usb_dc_ck = clk_get(0, "usb_dc_ck");
+	else
+		usb_dc_ck = clk_get(0, "lb_ck");
+
 	if (IS_ERR(usb_dc_ck)) {
 		clk_put(usb_host_ck);
 		return PTR_ERR(usb_dc_ck);

--FxlYARId5dseejUu
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--FxlYARId5dseejUu--
