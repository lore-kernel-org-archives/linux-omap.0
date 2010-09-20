From: Jorge Bustamante <jbustamante.init@gmail.com>
Subject: Requirement for DSI video mode support
Date: Mon, 20 Sep 2010 15:18:29 -0500
Message-ID: <AANLkTikBn63Y1CofZksexds7tBqzxrNvX3MD=tZ49hDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:57718 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757445Ab0ITUSa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Sep 2010 16:18:30 -0400
Received: by qyk36 with SMTP id 36so3171350qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Sep 2010 13:18:29 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com
Cc: m-iovescu1@ti.com, nm@ti.com, archit@ti.com, y-qassid@ti.com, a-aguirre@ti.com

Hi,

We (TI) have been working on a DSI video mode driver for OMAP4 and I
am aware that other people are working with similar drivers. We had to
tweak the code to make the drivers work with current code but we would
like to make it the correct way, that is, introducing a proper
functionality instead of inserting tweaks in the present command mode
driver. Therefore, there is an initiative from us to modify current
dss/dsi code to support DSI video mode.

We have collected a list of requirements and ideas (with the help of
ppl copied) from our experience working with these drivers, but it
would be great if you can discuss/comment further on this.

Requirements:

- A better way of exposing VC's to a panel driver, since most panels
use more than one VC. Currently the design supports only one per
panel. Perhaps a VC resource pool could be created.
- A way of imposing restrictions on clock sources based on dsi mode.
- Runtime calculation of required clocks and PLL parameters. This is
to reduce complexity in clock calculations, specially when having two
panels running at the same time.
- A way to pass specific requirements from panel driver to DSI driver
(enable/disable BTA, set HS Clk always on, etc).
- Remove some hardcoded values in dsi.c and make the panel pass the
information to DSI driver(RX, TX fifo sizes of VCs, enabling/disabling
dsi timers, etc)
- A cleaner way of handling both DSI1 and DSI2 blocks(and more in
omap5) in the same driver.
- A way to easily set non-burst event mode, non-burst pulse mode and
burst mode configuration as defined on DSI protocol specs.
- A way to calculate correct DSI blanking parameters based on panel
blanking requirements (for DSI Video panels, these will be have to be
specified statically somewhere, much like DPI displays).
- Remove timeout error/warnings when disabling dsi phy interface since
on video mode it should wait instead for next vsync.


Design ideas:

- It could actually be worthwhile to have separate files for command
and video mode and a core dsi driver file.

- We can have a enum like this to choose between modes:

plat/display.h can have an enum like:
enum omap_dss_dsi_mode {
=A0=A0=A0 OMAP_DSS_DSI_CMDMODE=A0=A0 =3D 1 << 0,
=A0=A0=A0 OMAP_DSS_DSI_VIDEOMODE =3D 1 << 1,

};
Nit pick - either make it #define and have bit offset as above OR
Better still, you wont need both at the same time, so bit offset wont b=
e
useful too much.. OMAP_DSS_DSI_CMDMODE =3D 1, OMAP_DSS_DSI_VIDEOMODE =3D=
 2,

- If we want a user to switch between modes, we may need to have a
member like "supported_modes" which could check if the desired mode is
supported by the panel. Switching between modes at runtime would be
quite unlikely (and hard). We might want to stick with the above if we
want a member like supported_modes:
=A0=A0=A0 .supported_modes =3D OMAP_DSS_DSI_CMDMODE | OMAP_DSS_DSI_VIDE=
OMODE;

- The dssdev struct can have a member dsi_mode of the above type.

- This would look nice in the board file and would also be useful if
there are multiple panels.

- We can have a bootarg to choose one of the modes (module parameter),
the driver can check against this member during init.


Let me know any comments...


Regards,
Jorge Bustamante
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
