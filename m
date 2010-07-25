From: Hari Kanigeri <hari.kanigeri@gmail.com>
Subject: Re: [PATCH 6/7] save and restore etm state across core OFF modes
Date: Sun, 25 Jul 2010 12:34:22 -0600
Message-ID: <AANLkTinmSJ6dtgqmyuk9CArniPEvEp7TrXauvGxLxv7x@mail.gmail.com>
References: <13B9B4C6EF24D648824FF11BE896716203BADA0745@dlee02.ent.ti.com>
	<1280077520-7538-7-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:32906 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab0GYSeY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Jul 2010 14:34:24 -0400
In-Reply-To: <1280077520-7538-7-git-send-email-virtuoso@slind.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Shishkin <virtuoso@slind.org>
Cc: linux-arm-kernel@lists.infradead.org, Richard Woodruff <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

> +config ENABLE_OFF_MODE_JTAG_ETM_DEBUG
> + =A0 =A0 =A0 bool "Enable hardware emulation context save and restor=
e"
> + =A0 =A0 =A0 depends on ARCH_OMAP3

-- Shouldn't this be depends on OMAP3_EMU instead ?

> + =A0 =A0 =A0 default y

-- As this is debug option, can you keep this "n" by default ?

> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This option enables JTAG & ETM debugging across pow=
er states.
> + =A0 =A0 =A0 =A0 With out this option emulation features are reset a=
cross OFF
> + =A0 =A0 =A0 =A0 mode state changes.
> +

Hari
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
