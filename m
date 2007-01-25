From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: Noise causes gpio interrupt
Date: Thu, 25 Jan 2007 03:43:35 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47080FF2@dlee13.ent.ti.com>
References: <7349.54565.qm@web55304.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Arnold <abo_gwapo@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I don't know about the GPIO module in 5912. If you have, you can try =
configuring your GPIO interrupt to level instead of edge interrupt. I =
don't know if debounce time can help you in fixing this.
=20
Regards,
Khasim=20

________________________________

From: linux-omap-open-source-bounces@linux.omap.com on behalf of Arnold
Sent: Thu 1/25/2007 3:40 AM
To: linux-omap-open-source@linux.omap.com
Subject: Noise causes gpio interrupt=20



Hi All,

I am working on omap5912 and I am using linux 2.6.17.
I am using a gpio to handle interrupts. I believe that
I am having a noise interrupt which my firmware thinks
is a really interrupt. Is there a way to distinguish a
noise interrupt from a real interrupt?


Thanks,
Arnold



_________________________________________________________________________=
___________
Now that's room service!  Choose from over 150,000 hotels
in 45,000 destinations on Yahoo! Travel to find your fit.
http://farechase.yahoo.com/promo-generic-14795097
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
