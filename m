From: vikas gupta <vikas.iet@gmail.com>
Subject: Re: omap 5912 serial driver
Date: Mon, 16 Jan 2006 09:11:13 +0530
Message-ID: <9cba36250601151941g7616df57ya0e8b9a379c66b5@mail.gmail.com>
References: <9cba36250601130644t2554c420x78373804a51a2949@mail.gmail.com>
	<20060114004342.GK5499@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060114004342.GK5499@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

So can you suggest me how i can test my serial driver
i need to check the functionality of inb/outb
Can any one provide some pointer on it


On 1/14/06, Tony Lindgren <tony@atomide.com> wrote:
>
> * vikas gupta <vikas.iet@gmail.com> [060113 06:50]:
> > hi all
> >
> >
> >
> > i am a naive user trying his hands on arm osk omap5912 board
> >
> >
> >
> > Well i wanted to know whether it is possible to test serial port on oma=
p
> > board by using inb/outb instruction as can be done in x86 platform...
> >
> > If it is possible then can u please suggest me a working example of one
> test
> > case doing this thing..
> >
> > I have tried my hands in it but wothout success on x86 platform below
> > mention program is working fine but on arm board it's not working so ca=
n
> > anyone help me ???
> >
> >
> >
> > Sorry, if the question seems naive as this is my initial attempt :)
> >
> >
> >
> > test program
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> >
> > include <stdio.h>
> >
> > #include <stdlib.h>
> >
> > #include <unistd.h>
> >
> > #include <sys/io.h>
> >
> >
> >
> > #define base 0x378
> >
> > #define value 255
> >
> >
> >
> > main(int argc, char **argv)
> >
> > {
> >
> >   int value1;
> >
> >   if (ioperm(base,1,1))
> >
> >     fprintf(stderr, "Couldn't get the port at %x\n", base), exit(1);
> >
> >
> >
> >    outb(value, base);
> >
> >    value1 =3D inb(base);
> >
> >   printf("value written is %d \n",value1);
> >
> > }
>
> It won't quite work as the IO address is different. Also inb/outb are
> mapped to __raw_readb/__raw_writeb.
>
> See these files:
>
> include/asm-arm/io.h
> include/asm-arm/arch-omap/io.h
>
> Tony
>
