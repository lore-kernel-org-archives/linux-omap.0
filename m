From: "LIMITED Nguyen Duong Thanh (CR/AEM Praktikant)" <DuongThanh.Nguyen@de.bosch.com>
Subject: AW: GPIO OF OMAP5912
Date: Tue, 29 Aug 2006 16:08:33 +0200
Message-ID: <B3FDBBC0428C8145A83F312B740CE67D075854@si-mail48.de.bosch.com>
References: <001e01c6cb36$7197e3d0$4e0aa8c0@wbb>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <001e01c6cb36$7197e3d0$4e0aa8c0@wbb>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "w.b.b" <rememberme_2000@126.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

I don't know if my idea help you.
Maybe the problem is about the libraries in directory /lib/ on OMAP file =
systems. It doesn't contain the libraries, which your program need.

Regard,
Thanh=20

-----Urspr=FCngliche Nachricht-----
Von: linux-omap-open-source-bounces@linux.omap.com =
[mailto:linux-omap-open-source-bounces@linux.omap.com] Im Auftrag von =
w.b.b
Gesendet: Dienstag, 29. August 2006 08:44
An: Linux-omap-open-source@linux.omap.com
Betreff: GPIO OF OMAP5912

hi:

 i want to do some work about OMAP5912'GPIO.but I am failed to do that.

 the following is a simple program:

test.c=20

-----------------------------------------------------

#include <stdio.h>
#include <unistd.h>
#include <asm/io.h>

#define GPIO3_OUT 0xfffbbc40 /* lp1 */

int main()
{
  /* Get access to the ports */
 =20
 =20
  /* Set the data signals (D0-7) of the port to all low (0) */
  outb(0xffff, GPIO3_OUT);
 =20
  /* Sleep for a while (100 ms) */
  usleep(100000);
}
-----------------------------------------------------
arm-linux-gcc -g test.c -o test.out
----------------------------------------------------
I run the binary file on the omap:./test.out
-----------------------------------------------------
but i get the result:segmentation falt!
---------------------------------------------------
who can provide me with information? if you have done work related with =
gpio,would you like send me some examplefile?                            =
   =20
   thanks!
