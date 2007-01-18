From: "Kim, Eun-Jung" <ejkim@ti.com>
Subject: RE: feedback for kernel 2.6.14 boot failure on OMAP2430 SDP
Date: Thu, 18 Jan 2007 12:42:55 +0800
Message-ID: <3FBEC599FC2F564D90877669C608C5B602B36418@dqhe01.ent.ti.com>
References: <9C23CDD79DA20A479D4615857B2E2C47080FB7@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C73ABB.22C8E996"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47080FB7@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C73ABB.22C8E996
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

fyi.

=20

Texas Instruments Korea, WTBU,

ejkim@ti.com <mailto:ejkim@ti.com> , +82-2-551-2814

________________________________

From: Syed Mohammed, Khasim=20
Sent: Thursday, January 18, 2007 1:40 PM
To: Kim, Eun-Jung; linux-omap-open-source@linux.omap.com
Subject: RE: feedback for kernel 2.6.14 boot failure on OMAP2430 SDP

=20

Hi EJ,

=20

The attachment is missing. Can you forward it directly?

=20

The combination u-boot "september version" and 2.6.14 kernel should work
directly for 2430SDP. Anyway I will review your patch and take the
necessary changes in next release.

=20

Thanks & Regards,

Khasim

________________________________

From: linux-omap-open-source-bounces+x0khasim=3Dti.com@linux.omap.com on
behalf of Kim, Eun-Jung
Sent: Wed 1/17/2007 8:36 PM
To: linux-omap-open-source@linux.omap.com
Subject: feedback for kernel 2.6.14 boot failure on OMAP2430 SDP

Hi.

This is EJ, a FAE of TIK. While my customer is working on Linux kernel
2.6.10 and 2.6.14, they found that 2.6.14 is not booting well on
OMAP2430 SDP. They modified "mux.h" to make it work and gave me a
feedback to enhance the BSP. We hope you review it apply to next release
if it is right. Hope it is helpful to you.

Regards,

EJ.



Texas Instruments Korea, WTBU,

ejkim@ti.com <mailto:ejkim@ti.com> , +82-2-551-2814





------_=_NextPart_001_01C73ABB.22C8E996
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C73ABB.22C8E996--
