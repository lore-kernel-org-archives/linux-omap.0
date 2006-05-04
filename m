From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Undefined usb_disconnect, was [PATCH] ARM: OMAP: Fix tlv320aic23.c
Date: Thu, 04 May 2006 18:08:50 +0200
Message-ID: <445A2712.1000606@gmail.com>
References: <4452384E.7080409@gmail.com> <20060503125606.GG30376@atomide.com>
	<4458F966.40504@gmail.com> <200605040751.45417.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200605040751.45417.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

David Brownell wrote:
> On Wednesday 03 May 2006 11:41 am, Dirk Behme wrote:
> 
>>WARNING: "usb_disconnect" [drivers/usb/host/ohci-hcd.ko]
>>undefined!
> 
> Of course, it hasn't been exported for a while now.
>>
>>Any ideas about USB? Seems that it comes from
>>drivers/usb/host/ohci-omap.c
> 
> I see a curious and pointless routine, ohci_omap_host_enable(), which
> isn't called from anywhere I can see, which wants usb_disconnect().
> 
> Try deleting that routine.

tahvo-usb.c uses ohci_omap_host_enable():

./drivers/cbus/tahvo-usb.c:88:extern int 
ohci_omap_host_enable(struct usb_bus *host, int enable);
./drivers/cbus/tahvo-usb.c:248: 
ohci_omap_host_enable(tu->otg.host, 1);
./drivers/cbus/tahvo-usb.c:266: 
ohci_omap_host_enable(tu->otg.host, 0);
./drivers/cbus/tahvo-usb.c:300: 
ohci_omap_host_enable(tu->otg.host, 0);
./drivers/cbus/tahvo-usb.c:338: 
ohci_omap_host_enable(tu->otg.host, 0);
./drivers/cbus/tahvo-usb.c:431: ohci_omap_host_enable(host, 0);

Regards

Dirk
