From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: cross compiling bluez-utils
Date: Wed, 9 May 2007 20:01:43 -0500
Message-ID: <B62D67BD8EC3324C8A3DACEEA1A0D6C60161E37E@dlee12.ent.ti.com>
References: <57314e840705091755o16799a68n43737b811800dc48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <57314e840705091755o16799a68n43737b811800dc48@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Try this (I can't try it right now so I hope it works for you)
wget http://bluez.sf.net/download/bluez-libs-2.10.tar.gz
wget http://bluez.sf.net/download/bluez-utils-2.10.tar.gz
wget http://bluez.sf.net/download/bluez-hcidump-1.12.tar.gz
wget http://bluez.sf.net/download/bluez-hciemu-1.0.tar.gz

Steve K.

-----Original Message-----
From: Budhee Jamaich [mailto:budheej@gmail.com]=20
Sent: Wednesday, May 09, 2007 5:56 PM
To: Kipisz, Steven
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: cross compiling bluez-utils

Hi Steven,

On 5/10/07, Kipisz, Steven <s-kipisz2@ti.com> wrote:
> I would suggest getting bluez-libs-2.10 and bluez-utils-2.10.
hmm.. can't find these... do you happen to know where they can be found
?

> The utils for 3.9 have more requirements than you really need.
>  A few weeks ago I was trying to
> cross-compile the utils for 3.9 or 3.10 (I cannot remember which) and
> they needed something that couldn't be cross-compiled without some
> configuration changes.

I tried today, utils 3.9 need dbus, but the dbus ./configure script
fails shouting it cannot do its tests in cross compiling mode...
in addition, the dbus need fortran (??) compiler, which i don't have
for arm...

I don't even know if I really want this dbus on OMAP. it sounds like
this dbus will take too much memory....

the question is whether bluez 2.1 will work under kernel 2.6.10 ?

Thank You
budhee
