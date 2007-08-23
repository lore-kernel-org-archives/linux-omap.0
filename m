From: Albert Santoni <ASantoni@evertz.com>
Subject: musb problems in git
Date: Thu, 23 Aug 2007 15:42:57 -0400
Message-ID: <0474A5584072DA1197F50007E90E6B1106C7E283@PORTIA>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "linux-omap-open-source (E-mail)" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi guys,

I pulled the latest musb changes from the OMAP tree into my local DaVinci
tree, and I'm experiencing a strange problem with the musb_hdrc driver now.

If I do a certain USB control transfer (that used to work before), dmesg
will spit out a bunch of these messages:
    
    ep0_txstate 495: odd; csr0 0000

... and the transfer will timeout. Any further communication from the host
to the gadget will also timeout. Upon trying to reload the musb_hdrc module,
insmod will freeze.

Lastly, the kernel also occasionally spits out these message:

    musb_g_ep0_irq 701: SETUP packet len 10 != 8 ?

I don't recall these messages occuring before I started using the updated
musb driver. (The last time I saw messages like this was when I had a flakey
USB cable, but I haven't changed my hardware configuration.)

Has anyone else experienced any problems running the latest musb code that's
in the OMAP tree on a DaVinci kernel?

Thanks,
Albert
