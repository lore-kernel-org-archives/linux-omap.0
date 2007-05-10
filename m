From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: cross compiling bluez-utils
Date: Wed, 9 May 2007 19:37:55 -0500
Message-ID: <B62D67BD8EC3324C8A3DACEEA1A0D6C60161E370@dlee12.ent.ti.com>
References: <57314e840705091523k23527156wa47412fb452a0ce6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <57314e840705091523k23527156wa47412fb452a0ce6@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I would suggest getting bluez-libs-2.10 and bluez-utils-2.10.  Those
cross-compile and work just fine.  The utils for 3.9 have more
requirements than you really need.  A few weeks ago I was trying to
cross-compile the utils for 3.9 or 3.10 (I cannot remember which) and
they needed something that couldn't be cross-compiled without some
configuration changes.

Steve K.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Budhee Jamaich
Sent: Wednesday, May 09, 2007 3:23 PM
To: linux-omap-open-source@linux.omap.com
Subject: cross compiling bluez-utils

hello all,

I have successfully cross compiled bluez-libs 3.9 to OMAP2430.

but, i have troubles to cross compile bluez-utils3.9.

has anyone had any success with it ?

did u manage to cross compile all dependencies ? dbus, hal, maybe
more...

I read that only the dbus process might take about 5MB of memory..
(do we have enough for it in OMAP2430 ?)

thank you ppl
budhee
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
