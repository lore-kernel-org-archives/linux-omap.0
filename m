From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: cross compiling for OMAP2430
Date: Tue, 17 Apr 2007 08:21:45 -0500
Message-ID: <B62D67BD8EC3324C8A3DACEEA1A0D6C6012B8B51@dlee12.ent.ti.com>
References: <782515bb0704170616w6fe8e474q2dded08e31d1e409@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <782515bb0704170616w6fe8e474q2dded08e31d1e409@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: nishanth menon <menon.nishanth@gmail.com>, Budhee Jamaich <budheej@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Budhee,
I agree with Nishanth.  I usually try to ./configure --help to see if
cross compiling is available.  If so, you typically do
./configure --target=3Darm-linux --build=3Di386-pc-linux =
--host=3Darm-linux

Sometimes it works...sometimes it doesnn't.

Another trick is
CC=3Darm-linux-gcc ./configure

After doing that, check the Makefile to see if CC really is set
correctly.  If all the above fail, then it is time to hand edit
Makefiles or use environments like openembedded.

Steve K.

-----Original Message-----
From: linux-omap-open-source-bounces+s-kipisz2=3Dti.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+s-kipisz2=3Dti.com@linux.omap.com]=

On Behalf Of nishanth menon
Sent: Tuesday, April 17, 2007 8:16 AM
To: Budhee Jamaich
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: cross compiling for OMAP2430

Hi Budhee,

On 4/16/07, Budhee Jamaich <budheej@gmail.com> wrote:
> Hm. Do I have to use such environment ? Can't I just choose the right
> ./configure parameter and the application will be built for the target
?
you may, but you need to look at a case by case basis. for example, if
u want to cross compile for ARM, busybox will need "make ARCH=3DARM
CROSS_COMPILE=3Darm-none-linux-gnueabi-" etc.. some apps dont know the
existance of CROSS_COMPILE.. and they'd use CC for the same, in which
case u'd have to do "make CC=3Darm-none-linux-gnueabi-gcc"..

personally, i hand compile most of my own stuff, some places, i'd have
to hack arnd "arm-unaware" apps.. but most places it is
straightforward.

I put some links in this discussion thread:
http://linux.omap.com/pipermail/linux-omap-open-source/2007-January/0088
41.html
the compiler link and busybox build info might be useful.

Regards,
Nishanth Menon
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
