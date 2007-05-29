From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: ADDING OMAP 3430 Support
Date: Tue, 29 May 2007 01:19:04 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47FF0E2C@dlee13.ent.ti.com>
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
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi all:

The following sequence of patch set is to add minimal OMAP3430 support =
to OMAP GIT. This patch is tested on TI's OMAP3430 SDP.

OMAP 3430 is an ARM Cortex A8 based Multimedia Application processor. =
For more information please visit:

http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=3D=
6123&navigationId=3D12643&contentId=3D14649

TBD:
	- Enable level-2 cache.
	- Identify required stuff from ARM's Cortex A8 patch set and try to 	=
bring them on OMAP GIT tree (temporarily till it gets into ARM tree).	- =
Add OMAP 3430 based driver support
	- Add OMAP3430 SDP based drivers support.

Reference:=20
	- ARM Cortex A8 patch from arm.com.
	- Patch set from Lauri (based on TI's BSP).

Please feel free to pass your review comments if any.

Regards,
Khasim
