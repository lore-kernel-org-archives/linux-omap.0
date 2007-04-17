From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: One NAND Booting
Date: Tue, 17 Apr 2007 12:00:41 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429C8DD96@dlee13.ent.ti.com>
References: <3B6D69C3A9EBCA4BA5DA60D913027429C8DCB4@dlee13.ent.ti.com>
	<42E999AD7A0E4647BF159F467EE4FBCBE649FF@BLR-SGM-MSG01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <42E999AD7A0E4647BF159F467EE4FBCBE649FF@BLR-SGM-MSG01.wipro.com>
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

Look at the archive for this group.

=20

I posted the exact steps for burning into OneNAND such that it boots.
If you follow those you will boot on the SDP as I can today.

=20

You are free to create another method if you must, but it doesn't seem
necessary.

=20

Regards,

Richard W.

=20

________________________________

From: sathish.madhava@wipro.com [mailto:sathish.madhava@wipro.com]=20
Sent: Tuesday, April 17, 2007 11:09 AM
To: Woodruff, Richard; linux-omap-open-source@linux.omap.com
Subject: RE: One NAND Booting

=20

Hi,

My requirement is to use entirely OneNAND and not to use NAND.,

if thats the case how do i fit the X-loader code in 1KB of OneNAND
BootRAM area.

=20

-Sathish

________________________________

From: Woodruff, Richard [mailto:r-woodruff2@ti.com]
Sent: Tue 4/17/2007 8:55 PM
To: Sathish kumar tekal Sethu madhava rao (WT01 - Wireless Networks and
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


The information contained in this electronic message and any attachments
to this message are intended for the exclusive use of the addressee(s)
and may contain proprietary, confidential or privileged information. If
you are not the intended recipient, you should not disseminate,
distribute or copy this e-mail. Please notify the sender immediately and
destroy all copies of this message and any attachments.=20

WARNING: Computer viruses can be transmitted via email. The recipient
should check this email and any attachments for the presence of viruses.
The company accepts no liability for any damage caused by any virus
transmitted by this email.

www.wipro.com
=09
