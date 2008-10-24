From: "Shah, Hardik" <hardik.shah@ti.com>
Subject: [PATCH 0/4] OMAP 2/3 DSS Library and V4L2 Display Driver
Date: Fri, 24 Oct 2008 15:20:18 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02D629792A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60274 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbYJXJze convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Oct 2008 05:55:34 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "video4linux-list@redhat.com" <video4l>

Hi All,
I will be posting the version 2 of the DSS library and V4L2 display dri=
ver=20
with almost all the comments from the community taken care of.
It will be series of 4 patches containing

OMAP 2/3 DSS Library
OMAP3 EVM TV encoder Driver.
New IOCTLS added to V4L2 Framework (Already posted on V4L2 mailing list=
)
OMAP 2/3 V4L2 Display driver on the Video planes of DSS hardware.

We are enhancing the DSS library.  This is the first post containing th=
e
features like power management, video pipeline, Digital overlay manager=
,
clock management support.

=46urther plan is to add graphics pipeline, LCD overlay manager, RFBI, =
DSI,
support and frame buffer interface for graphics pipeline

Please let us know your comments on further enhancements of the DSS Lib=
rary
and V4L2 display driver.

=46urther discussions on DSS Library and V4L2 driver can be found at be=
low threads.

http://lists-archives.org/video4linux/24597-new-display-subsystem-for-o=
map2-3.html
http://lists-archives.org/video4linux/24409-omap2-3-dss-library.html
http://lists-archives.org/video4linux/24410-omap-2-3-v4l2-display-drive=
r-on-video-planes.html
http://lists-archives.org/video4linux/24600-omap-2-3-v4l2-display-drive=
r-on-video-planes.html

=A0
Thanks and Regards,
Hardik Shah
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
