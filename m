From: "zil iram" <zil_iram@hotmail.com>
Subject: SPI pins on omap5912
Date: Wed, 24 Jan 2007 14:21:12 +0000
Message-ID: <BAY130-F68DE0B2ECF2ECFB623DA6F8AC0@phx.gbl>
References: <1169480869.S.3614.7806.webmail19.rediffmail.com.old.1169617347.19221@webmail.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1169480869.S.3614.7806.webmail19.rediffmail.com.old.1169617347.19221@webmail.rediffmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I am using linux 2.6.17 on the omap5912 board. I would like to use the spif 
pins, spif_cs0, spif_din, spif_dout, spif_sck on the board and connect them 
to the spi pins on my device. Do I still need to make my own controller 
driver for the spi framework? Or can I use the omap_uwire?

Thanks,
Lizette

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar - get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/
