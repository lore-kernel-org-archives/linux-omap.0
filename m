From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Fri, 27 Nov 2015 13:27:23 +0000
Message-ID: <20151127132722.GA30871@n2100.arm.linux.org.uk>
References: <20150713131902.GH26485@atomide.com>
 <20151123144545.GD24147@pali>
 <20151125181644.GI2517@atomide.com>
 <17134653.86P3dFyQKK@wuerfel>
 <20151125210310.GT2517@atomide.com>
 <56568849.5080103@gmail.com>
 <20151126090739.GD14190@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151126090739.GD14190@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Laura Abbott <lauraa@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robherring2@gmail.com>, Will Deacon <will.deacon@arm.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 26, 2015 at 10:07:39AM +0100, Pali Roh=E1r wrote:
> On Wednesday 25 November 2015 20:19:21 Frank Rowand wrote:
> > > Or populate /proc/atags only for the ones that need it from machi=
ne
> > > specific init_early?
> >=20
> > This is circling back to the first comment from Russell King where
> > he suggested a legacy file for the N900 which calls save_atags():
> >=20
> >     Are the ATAGs at a fixed address on the N900?  Can that be hand=
led in
> >     some kind of legacy file for the N900 which calls save_atags() =
on it, so
> >     we don't end up introducing yet more stuff that we have to main=
tain into
> >     the distant future?  If not, what about copying a known working=
 atag
> >     structure into a legacy file for the N900?
> >=20
> > It seems to me that patches 1, 2, 4, and 5 could be replaced by thi=
s
> > approach.
>=20
> Hi Frank, in this case I will ask my question again: It is possible t=
o
> read atags from that legacy file. And if yes how? I was not thinking
> about this approach because somebody in past wrote that this is not
> possible...

It is possible to redirect any program to open any other file.  You can
do it via a LD preload, and intercepting the open(), and possibly the
read() calls if you want to do something more fancy.  The down-side is
that you have to arrange for the preloaded object to be used by the
linker, and the additional overhead it places on the intercepted
functions.

Eg,

openatags.c:

#define open libc_open
#include <fcntl.h>
#undef open
#include <string.h>

int open(const char *pathname, int flags, mode_t mode)
{
        static int (*old_open)(const char *pathname, int flags, mode_t =
mode);

        if (strcmp(pathname, "/proc/atags") =3D=3D 0)
		pathname =3D "/tmp/my-atags";

        if (!old_open)
                old_open =3D dlsym(RTLD_NEXT, "open");

        return old_open(pathname, flags, mode);
}

Build the above (untested) with:
gcc -O2 -o openatags.o -c openatags.c
gcc -shared -o openatags.so openatags.o -ldl

Now, when running one of these programs, you can test it with:
LD_PRELOAD=3Dopenatags.so /name/of/program

You could also list the full pathname to openatags.so in /etc/ld.so.pre=
load,
but test it first, because it will always be used by the linker in that
case, and you wouldn't want normal commands to misbehave.

Note that putting it in /etc/ld.so.preload will also have the effect th=
at
cat /proc/atags will also get redirected to /tmp/my-atags too.

--=20
=46TTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
