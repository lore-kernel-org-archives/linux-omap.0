From: "Kanagesh R" <kanagesh@india.com>
Subject: Linksys WCF54 Card on OSK
Date: Sun, 18 Dec 2005 19:55:42 +0800
Message-ID: <20051218115542.7FD17CA0A3@ws5-11.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

Hello,

I'm trying to get a LInksys WCF54G 802.11g wireless CF card to=20
work with the OSK.  I started off by first trying to get a=20
CF memory card working with the OSK.  I configured the kernel
for PCMCIA CF support, compiled and configured pcmcia-cs and=20
tested a Sandisk CF memory card (1G).  Works fine - mounts, am
able to copy to the card and from the card.=20=20

My configurations are as follows:
Linux kernel - 2.6.13-omap1
shell - bash-3.0
card services - pcmcia-cs-3.2.7
wlan-drivers - linux-wlan-ng-0.2.3

I've got linux-wlan-ng configured and compiled.  When I insert the=20
Linksys card, I see from the prints that the card is detected:

cardmgr[743]: socket 0: Linksys WCF54G
cardmgr[743]: executing: 'modprobe prism2_cs 2>&1'
cardmgr[743]: + Using /lib/modules/2.6.13-omap1/linux-wlan-ng/p80211.ko
prism2cs_init: prism2_cs.o: 0.2.3 Loaded
prism2cs_init: dev_info is: prism2_cs
cardmgr[743]: + Using /lib/modules/2.6.13-omap1/linux-wlan-ng/prism2_cs.ko

and using modprobe, it loads the drivers (p80211.ko and prism2_cs.ko) also.

I've probed further using cardctl:

'cardctl status' gives me:

3.3V 16-bit PC Card
function 0: [ready]

after i eject the card, 'cardctl status' shows:

no card

However, when the card is in the CF slot and cardmgr says it has=20
detected it, the card doesn't seem to draw power as the power led
on the card is idle.=20=20

Has anyone managed to get any wireless card working with the OSK?

Thank you for your time,

Regards,
Kanagesh






--=20
India.com free e-mail - www.india.com.=20
Check out our value-added Premium features, such as an extra 20MB for mail =
storage, POP3, e-mail forwarding, and ads-free mailboxes!
