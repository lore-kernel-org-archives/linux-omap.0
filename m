From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: clock regression and note.
Date: Fri, 10 Aug 2007 15:29:26 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429019C4F91@dlee13.ent.ti.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Paul,

When booting 2430 it looks like its calculating the crystal rate wrong =
now. Likely one of your fixes needs a tweak for 2430.  I noticed the =
bogomips was too low.  Then I see the proc/omap_clocks was gone.  Right =
now a few user space entities read this to get cpurate.  Seems Igor told =
me the N800 user space monitor might do this also.  It would be nicer to =
leave this part out of the debug define.

2430 has a 26MHz input which gets /2 to 13Mhz by the first level =
divider.  One of your patches did touch this.

<6>Clocking rate (Crystal/DPLL/MPU): 6.5/330/165 MHz
<3>Clock apll54_ck didn't lock in 100000 tries
<6>GPMC revision 3.0
<6>IRQ: Found an INTC at 0xd80fe000 (revision 3.0) with 96 i

I'll take a quick look.

Regards,
Richard W.
