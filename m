From: max <mboure@ubiquiet.com>
Subject: OMAP reaction facing a multiple devices definition by muxing
Date: Fri, 30 Oct 2009 09:52:08 +0100
Message-ID: <1256892728.14448.6.camel@dell-desktop.example.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail15.dotsterhost.com ([66.11.233.45]:58970 "EHLO
	mail15.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755003AbZJ3I6q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 04:58:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I have a question concerning the mux and the OMAP's reaction.

How does the omap reacts when you define a register for a specific
device that is already initiated as primary mode of another register ?
=46or example CONTROL_PADCONF_UART1_ defines the uart1 in primary mode =
but
when you mux the register CONTROL_PADCONF_MCBSP_CLKS into mode 5 (and
the other apropiate registers for the uart1) how does the OMAP reacts ?

Thank you for your answer.=20

Best regard,

Maxime Bour=C3=A9

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
