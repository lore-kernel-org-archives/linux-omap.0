From: Nachiappan <tonachi@gmail.com>
Subject: omap 1510 camera interface -ov6x30.c recognising fault
Date: Wed, 12 Apr 2006 09:45:57 +0530
Message-ID: <b4638ae70604112115g29f8342dwb33e352469b3cc4c@mail.gmail.com>
References: <b4638ae70604110214g24db98c1s5e34690a96c16cf4@mail.gmail.com>
	<b4638ae70604110229l29fa6bc6nc854c481f0cd056b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <b4638ae70604110229l29fa6bc6nc854c481f0cd056b@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 Dear All,


Iam working on TI-OMAP 1510 -innovator break up board. -[TI 925t arm based]
 Iam finding difficulty in OV6x30 camera getting identified.


When iam in stage of compiling the linux kernel.

using make ARCH=3Darm menu config

In selecting multi media devices
have opted for video for linux,
selected video proc file systems

 but i dont get any option of selecting ov6x30 camera in that place.

Can Any one suggest me kernel compilation .....what exactly has to be opted
as modules in kernel compilation [make arch=3Darm menu config] for getting
ov6x30.c

When i go to the folder and verify whether that OV6X30 driver routine is
there.
I find that it is present in ./root/drivers/media/video/omap/camera-ov6x30.=
c

but still i dont get that highlighted when iam in stage of kernel
compilation.



So at the time of booting kernel i dont find this camera device at all.


Files i have used are


   1. linux-2.4.19.tar
   2. patch-2.4.19-rmk7.bz2
   3. patch-2.4.19-rmk7-omap1.bz2
   4. rrload-innovator-0301151120.tar.bz2

for tool chain:

   1. binutils-2.12.1.tar.bz2
   2. gcc-2.95.3.tar.gz
   3. glibc-2.2.3.tar.gz
   4. glibc-linuxthreads-2.2.3.tar.gz

Iam expecting ur replies eagerly.

thanking you,
  Nachiappan
