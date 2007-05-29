From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: PRCM_SYSCONFIG offset now wrong for OMAP2
Date: Tue, 29 May 2007 16:06:52 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901158B15@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Paul,

I just fired up my H4 and was checking out register settings on the =
emulator and measuring current of the current drop.

I see that you have entered the wrong offsets for OMAP24XX_PRCM_REVISION =
and OMAP24XX_PRCM_SYSCONFIG.  0x4 and 0x14 are wrong.  It should be 0x0 =
and 0x10.

This results in the autoidle for the PRCM not being set and an extra 2mA =
consumption.

Regards,
Richard W.
