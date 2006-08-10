From: "LIMITED Nguyen Duong Thanh (CR/AEM Praktikant)" <DuongThanh.Nguyen@de.bosch.com>
Subject: AW: Write to file
Date: Thu, 10 Aug 2006 16:33:22 +0200
Message-ID: <B3FDBBC0428C8145A83F312B740CE67D07583B@si-mail48.de.bosch.com>
References: <9713be7f0608080125r5f6e992fi30ad23287381ff30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <9713be7f0608080125r5f6e992fi30ad23287381ff30@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Sergey Vointsev <vointsev@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thanks alot Sergey,=20

The problem is solved. I can read and write perfectly now on NFS.

Regard,
Nguyen

-----Urspr=FCngliche Nachricht-----
Von: =
linux-omap-open-source-bounces+duongthanh.nguyen=3Dde.bosch.com@linux.oma=
p.com =
[mailto:linux-omap-open-source-bounces+duongthanh.nguyen=3Dde.bosch.com@l=
inux.omap.com] Im Auftrag von Sergey Vointsev
Gesendet: Dienstag, 8. August 2006 10:26
An: linux-omap-open-source@linux.omap.com
Betreff: Re: Write to file

Hi, Nguyen!

As I understand, there aren't some special commands for read/write
files on OMAP. At least the following simple program worked fine on
both my desktop and my OSK5912:

********************
#include <stdio.h>
int main()
{
	FILE *f;
	f =3D fopen ("/tmp/testfile","a+");
	fprintf (f,"Hello! \n");
	fclose (f);
	return 0;
}
********************

I have rootfs mounted via NFS, but I believe it doesn't really matter.
So you should check the following things:
1. is your filesystem mounted in rw mode or only for reading
2. does you program have permissons (chmod/chown I mean) for writing
to the directory you use

Sergey.
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
