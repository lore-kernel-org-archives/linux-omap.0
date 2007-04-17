From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: One NAND Booting
Date: Tue, 17 Apr 2007 10:25:09 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429C8DCB4@dlee13.ent.ti.com>
References: <42E999AD7A0E4647BF159F467EE4FBCBE649FC@BLR-SGM-MSG01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <42E999AD7A0E4647BF159F467EE4FBCBE649FC@BLR-SGM-MSG01.wipro.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: sathish.madhava@wipro.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> I am trying to do One NAND Booting on OMAP2430sdp.
> I found that I need to have X-loader image which fits in 1KB=20
> of Boot RAM.
> Currently the X-loader code i have is around 6KB, can=20
> somebody suggest where to get this 1KB size X-loader Code.

You likely don't need this.  The xloading on the TI site can already
boot from OneNAND on the 2430sdp.

Mask ROM code runs and loads code from NAND into SRAM to be executed.
You are limited by your SRAM space (as used by the mask ROM) and block
size of the flash device not the XIP space in the OneNAND.

Regards,
Richard W.
