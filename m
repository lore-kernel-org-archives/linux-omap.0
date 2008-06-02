From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: FW: driver DVI output OMAP3 EVM
Date: Mon, 2 Jun 2008 17:38:24 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C001DE4464FE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38525 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752792AbYFBMIs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jun 2008 08:08:48 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m52C8RPh017783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 2 Jun 2008 07:08:37 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m52C8MaK009127
	for <linux-omap@vger.kernel.org>; Mon, 2 Jun 2008 07:08:26 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Royer, Fabien" <f-royer@ti.com>

Resending: I think you have received the attachments if not do let me know.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-open-source-
> bounces@linux.omap.com] On Behalf Of Royer, Fabien
> Sent: Monday, June 02, 2008 4:55 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: driver DVI output OMAP3 EVM
>
> Hello,
>
> I would like to know how to drive the DVI output on the OMAP3 EVM.
>

Hi Fabien,

If you use TI's release for OMAP3 EVM then the mods required to get DVI working is as given below, basically it is hardcoded version, LCD will not work from there on. At present we don't have a  version that allows you to dynamically switch between DVI and LCD. The files attached are bit old, may be you have to twik in a bit to get it compiled.

Hardware:

On EVM 3530 Base board, replace the Resistor R18 (It's near to DVI connector [TOP SIDE] of the board) with a 510 ohm (its 10K now).

Software:

The attached files have to be copied to respective directories.

- arch/arm/plat-omap/display.c
- drivers/video/omap/omap_disp_out.c
- drivers/video/omap/omap_fb.c

Changes for different resolution:

It is now configured for 1280x720. If you want to modify it to your monitor resolution then do the following.

1) In arch/arm/plat-omap/display.c function omap2_disp_set_panel_size()

dispc_reg_out(DISPC_SIZE_LCD,0x2CF04FF); /* it is 720 = 2cf , 1280 = 0x4ff */

2) In drivers/video/omap/omap_disp_out.c
#define H4_LCD_XRES             1280   /* Change these */
#define H4_LCD_YRES             720

Regards,
Khasim
