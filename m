From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v3] serial: Add OMAP high-speed UART driver
Date: Mon, 7 Jun 2010 12:19:05 +0530
Message-ID: <AANLkTinRsFvGv0HPYtDjYUM5fwA_A04T8VeIQWe6dOC3@mail.gmail.com>
References: <33418.192.168.10.88.1275659646.squirrel@dbdmail.itg.ti.com>
	<201006051348.30425.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43830 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab0FGGtI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 02:49:08 -0400
In-Reply-To: <201006051348.30425.luke@dashjr.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

On Sun, Jun 6, 2010 at 12:18 AM, Luke-Jr <luke@dashjr.org> wrote:
> How do I actually get this to work? Built a kernel with it for my N81=
0, but
> there's no ttyO* (I'm using devtmpfs)...

Hope your are trying to use Kevins Wip-UART branch.
Since platform data support is currently available in that branch.

If your are using kevins wip-uart branch then,
ensure you have selected omap-serial driver

Symbol: SERIAL_OMAP [=3Dy]
  =E2=94=82 Prompt: OMAP serial port support
  =E2=94=82   Defined at drivers/serial/Kconfig:1383
  =E2=94=82   Depends on: HAS_IOMEM [=3Dy] && (ARCH_OMAP2 [=3Dy] || ARC=
H_OMAP3
[=3Dy] || ARCH_OMAP4 [=3Dy])
  =E2=94=82   Location:
  =E2=94=82     -> Device Drivers
  =E2=94=82       -> Character devices
  =E2=94=82         -> Serial drivers
  =E2=94=82   Selects: SERIAL_CORE [=3Dy]


Also ensure /etc/inittab is update with ttyO* for console usage.
Update console bootparam accordingly based on UART used.

=46or ex: if uart3 is used as console use console=3DttyO2.

---
Regards,
Govindraj.R


> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
