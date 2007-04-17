From: <sathish.madhava@wipro.com>
Subject: RE: One NAND Booting
Date: Tue, 17 Apr 2007 21:39:24 +0530
Message-ID: <42E999AD7A0E4647BF159F467EE4FBCBE649FF@BLR-SGM-MSG01.wipro.com>
References: <3B6D69C3A9EBCA4BA5DA60D913027429C8DCB4@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: r-woodruff2@ti.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
My requirement is to use entirely OneNAND and not to use NAND.,
if thats the case how do i fit the X-loader code in 1KB of OneNAND =
BootRAM area.
=20
-Sathish

________________________________

From: Woodruff, Richard [mailto:r-woodruff2@ti.com]
Sent: Tue 4/17/2007 8:55 PM
To: Sathish kumar tekal Sethu madhava rao (WT01 - Wireless Networks and =
Devices); linux-omap-open-source@linux.omap.com
Subject: RE: One NAND Booting



> I am trying to do One NAND Booting on OMAP2430sdp.
> I found that I need to have X-loader image which fits in 1KB
> of Boot RAM.
> Currently the X-loader code i have is around 6KB, can
> somebody suggest where to get this 1KB size X-loader Code.

You likely don't need this.  The xloading on the TI site can already
boot from OneNAND on the 2430sdp.

Mask ROM code runs and loads code from NAND into SRAM to be executed.
You are limited by your SRAM space (as used by the mask ROM) and block
size of the flash device not the XIP space in the OneNAND.

Regards,
Richard W.
