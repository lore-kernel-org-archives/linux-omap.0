From: Hingkwan Huen <hkh@cypress.com>
Subject: Re: AW: GPIO OF OMAP5912
Date: Tue, 29 Aug 2006 09:50:23 -0700
Message-ID: <1156870223.2844.28.camel@localhost.localdomain>
References: <B3FDBBC0428C8145A83F312B740CE67D075854@si-mail48.de.bosch.com>
Reply-To: hkh@cypress.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <B3FDBBC0428C8145A83F312B740CE67D075854@si-mail48.de.bosch.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "LIMITED Nguyen Duong Thanh (CR/AEM Praktikant)" <DuongThanh.Nguyen@de.bosch.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Don't think you can access physical memory directly in user space. You
should use /dev/mem instead.

-kwan

On Tue, 2006-08-29 at 16:08 +0200, LIMITED Nguyen Duong Thanh (CR/AEM
Praktikant) wrote:
> Hello,
>=20
> I don't know if my idea help you.
> Maybe the problem is about the libraries in directory /lib/ on OMAP fil=
e systems. It doesn't contain the libraries, which your program need.
>=20
> Regard,
> Thanh=20
>=20
> -----Urspr=C3=BCngliche Nachricht-----
> Von: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-o=
pen-source-bounces@linux.omap.com] Im Auftrag von w.b.b
> Gesendet: Dienstag, 29. August 2006 08:44
> An: Linux-omap-open-source@linux.omap.com
> Betreff: GPIO OF OMAP5912
>=20
> hi:
>=20
>  i want to do some work about OMAP5912'GPIO.but I am failed to do that.
>=20
>  the following is a simple program:
>=20
> test.c=20
>=20
> -----------------------------------------------------
>=20
> #include <stdio.h>
> #include <unistd.h>
> #include <asm/io.h>
>=20
> #define GPIO3_OUT 0xfffbbc40 /* lp1 */
>=20
> int main()
> {
>   /* Get access to the ports */
>  =20
>  =20
>   /* Set the data signals (D0-7) of the port to all low (0) */
>   outb(0xffff, GPIO3_OUT);
>  =20
>   /* Sleep for a while (100 ms) */
>   usleep(100000);
> }
> -----------------------------------------------------
> arm-linux-gcc -g test.c -o test.out
> ----------------------------------------------------
> I run the binary file on the omap:./test.out
> -----------------------------------------------------
> but i get the result:segmentation falt!
> ---------------------------------------------------
> who can provide me with information? if you have done work related with=
 gpio,would you like send me some examplefile?                           =
    =20
>    thanks!
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
>=20
