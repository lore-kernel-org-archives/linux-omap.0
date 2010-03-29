From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: USB on omap2430
Date: Mon, 29 Mar 2010 23:41:59 +0300
Message-ID: <20100329204159.GC31402@nokia.com>
References: <70376CA23424B34D86F1C7DE6B997343017F5D5BE1@VSHINMSMBX01.vshodc.lntinfotech.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032221A9F3@dbde02.ent.ti.com>
 <70376CA23424B34D86F1C7DE6B997343017F5D5BE3@VSHINMSMBX01.vshodc.lntinfotech.com>
 <70376CA23424B34D86F1C7DE6B997343017F5D5BE7@VSHINMSMBX01.vshodc.lntinfotech.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <70376CA23424B34D86F1C7DE6B997343017F5D5BE7-fVvhrSDAkVjuuPCCJ6VnObSn4PsL5ZDKvpI+GvaZM4lBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Viral Mehta <Viral.Mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
Cc: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi again,

On Fri, Mar 26, 2010 at 12:08:11PM +0100, ext Viral Mehta wrote:
>I enabled "earlyprintk" and I have copy+pasted crashdump at the end of the email.
>
>It is not able to get "otg_get_transceiver()" since transceiver was never set.
>OMAP2430 uses ISP1301 (grepped from SDP manual).
>It is on I2C1 bus and address 0x2D if I read the manual correctly.

isp1301 ?? there's a driver for that on drivers/usb/otg/isp1301_omap.c

enable that and check if it works. You should add something like the 
following to your board file:

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 01d113f..910234d 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -172,6 +172,11 @@ static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] = {
  		.irq = INT_24XX_SYS_NIRQ,
  		.platform_data = &sdp2430_twldata,
  	},
+	{
+		I2C_BOARD_INFO("isp1301-omap", 0x2d),
+		.flags = I2C_CLIENT_WAKE,
+		.irq = /* irq line here */,
+	},
  };
  
  static int __init omap2430_i2c_init(void)

I didn't even compile tested... you will probably need the schematics to 
figure out to which i2c bus isp1301 is connected.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
