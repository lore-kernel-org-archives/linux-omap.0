From: "Marco Candiago" <Marco.Candiago@nicta.com.au>
Subject: Problem Loading Ramdisk from flash to SDRAM
Date: Sat, 25 Mar 2006 09:50:55 +1100
Message-ID: <09D3F703EF3B0A4CBE28449EA9F3D320477AC0@nicta-atp-mail.in.nicta.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
content-class: urn:content-classes:message
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


Hello all,

I'm developing with Innovator 1510 platform.

I'm having a problem of booting my ramdisk from flash memory.

The kernel gets loaded from flash into RAM with no problem, however, at
the end of the kernel boot message I get the ... Couldn't find valid
ramdisk image starting at 0.

I have no problems at all when I use rrload to load the file system into
RAM with

LA=3D  11700000 and EA=3D  11700000=0D

With my kernel boot line:  initrd=3D0x11700000,8m root=3D/dev/ram0
console=3DttyS0,115200n8

However when I use rrload to store the filesystem from RAM to flash and
then=0D
Power off and boot, I run into the can't find valid ramdisk problem.

I think it is a simple matter of specifying the correct address of the
initrd, however how do I determine where rrload is placing the
initramdisk
In RAM memory?  It was not evident to me when looking through the rrload
source.

Marco

--------------------------------------------------------------------------
This email and any attachments may be confidential. They may contain=
 legally
privileged information or copyright material. You should not read, copy,
use or disclose them without authorisation. If you are not an intended
recipient, please contact us at once by return email and then delete both
messages. We do not accept liability in connection with computer virus,
data corruption, delay, interruption, unauthorised access or unauthorised
amendment. This notice should not be removed.
