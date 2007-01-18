From: "Kim, Eun-Jung" <ejkim@ti.com>
Subject: feedback for kernel 2.6.14 boot failure on OMAP2430 SDP
Date: Thu, 18 Jan 2007 10:36:17 +0800
Message-ID: <3FBEC599FC2F564D90877669C608C5B602B36179@dqhe01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C73AA9.6F5C8A42"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C73AA9.6F5C8A42
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi.

This is EJ, a FAE of TIK. While my customer is working on Linux kernel
2.6.10 and 2.6.14, they found that 2.6.14 is not booting well on
OMAP2430 SDP. They modified "mux.h" to make it work and gave me a
feedback to enhance the BSP. We hope you review it apply to next release
if it is right. Hope it is helpful to you.

Regards,

EJ.

=20

Texas Instruments Korea, WTBU,

ejkim@ti.com <mailto:ejkim@ti.com> , +82-2-551-2814

=20


------_=_NextPart_001_01C73AA9.6F5C8A42
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C73AA9.6F5C8A42--
