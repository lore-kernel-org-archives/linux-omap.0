From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: cross compiling for OMAP2430
Date: Tue, 17 Apr 2007 09:19:03 -0500
Message-ID: <B62D67BD8EC3324C8A3DACEEA1A0D6C6012B8BE6@dlee12.ent.ti.com>
References: <57314e840704170651r298a4a7fl89a121c380828f18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <57314e840704170651r298a4a7fl89a121c380828f18@mail.gmail.com>
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

Use Google.

Also you should get a book or two on Embedded Linux.  The O'Reilly book
with the name something like "Building Embedded Linux Systems" or
another book with a name like "Embedded Linux Primer" that I think is
from Prentice Hall.  I've loaned out mine so I don't have the exact
titles or publishers.

Steve K.

-----Original Message-----
From: Budhee Jamaich [mailto:budheej@gmail.com]=20
Sent: Tuesday, April 17, 2007 8:52 AM
To: Kipisz, Steven
Cc: nishanth menon; linux-omap-open-source@linux.omap.com
Subject: Re: cross compiling for OMAP2430

Hi Steve and Nishanth,

On 4/17/07, Kipisz, Steven <s-kipisz2@ti.com> wrote:
> Hi Budhee,
> I agree with Nishanth.  I usually try to ./configure --help to see if
> cross compiling is available.  If so, you typically do
> ./configure --target=3Darm-linux --build=3Di386-pc-linux =
--host=3Darm-linux

can you plz explain what is each flag ? let's say my host (where I
compile
the application) is a normal i386 PC, and the target is OMAP2430,
then are these the correct flags ?

> Another trick is
> CC=3Darm-linux-gcc ./configure

why do I need to use arm-linux-gcc ? can't the standard gcc compile for
arm ?

Thank YOu
Budhee
