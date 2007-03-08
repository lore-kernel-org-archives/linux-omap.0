From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: U-Boot prompt is not visible
Date: Thu, 8 Mar 2007 06:07:28 -0600
Message-ID: <B62D67BD8EC3324C8A3DACEEA1A0D6C6D3EB09@dlee12.ent.ti.com>
References: <61445c750703080358jd7e2b76sbd010420b975bef8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <61445c750703080358jd7e2b76sbd010420b975bef8@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Pharaoh ." <pharaoh137@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I usually use a tool such as Code Composer or Trace32 to download and
run ELF.  I haven't used OST in a while, but I recall you can rename the
u-boot.bin to u-boot.raw and download and run that file.  OST definitely
support raw binary formats.

If you want to flash an image, you must flash u-boot.bin (I used to
always rename to u-boot.raw).  The reason I renamed from .bin to .raw is
because some versions of the tools would assume a .bin file was a WinCE
image and would either download or flash differently than a true binary
image.

Steve K.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Pharaoh .
Sent: Thursday, March 08, 2007 5:59 AM
To: linux-omap-open-source@linux.omap.com
Subject: U-Boot prompt is not visible

Hi
I have loaded the u-boot.elf binary to RAM over UART using the OST
utility on Windows XP. The ELF binary which is compiled on Linux for
omap730p2
sample board gets successfully downloaded to RAM at the specified
address. I have configured the UART as mentioned in the manual by
using Hyperterminal. After downloading the ELF binary to RAM, I should
be seeing the U-boot prompt on console. But, just a cursor blinks on
screen. I am sure the  connection is being established but no prompt
is seen.

The OST tool says that the image is downlaoded to RAM successfully and
it is executing at address XXXXXX. How can check whether U-Boot image
is really in RAM and executing?

If burning ELF is correct then what might have gone wrong ? Why the
u-boot prompt is not visible? What I am missing? I have checked the
COM1 setting and they are as they should be.

-Pharaoh.
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
