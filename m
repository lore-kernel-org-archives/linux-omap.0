From: vikas gupta <vikas.iet@gmail.com>
Subject: omap 5912 serial driver
Date: Fri, 13 Jan 2006 20:14:33 +0530
Message-ID: <9cba36250601130644t2554c420x78373804a51a2949@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

hi all



i am a naive user trying his hands on arm osk omap5912 board



Well i wanted to know whether it is possible to test serial port on omap
board by using inb/outb instruction as can be done in x86 platform...

If it is possible then can u please suggest me a working example of one tes=
t
case doing this thing..

I have tried my hands in it but wothout success on x86 platform below
mention program is working fine but on arm board it's not working so can
anyone help me ???



Sorry, if the question seems naive as this is my initial attempt :)



test program

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D



include <stdio.h>

#include <stdlib.h>

#include <unistd.h>

#include <sys/io.h>



#define base 0x378

#define value 255



main(int argc, char **argv)

{

  int value1;

  if (ioperm(base,1,1))

    fprintf(stderr, "Couldn't get the port at %x\n", base), exit(1);



   outb(value, base);

   value1 =3D inb(base);

  printf("value written is %d \n",value1);

}





vikas
