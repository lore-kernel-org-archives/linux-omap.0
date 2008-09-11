From: Arno Steffen <arno.steffen@web.de>
Subject: Setup of tools / include path ?
Date: Thu, 11 Sep 2008 15:41:47 +0200
Message-ID: <290843612@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fmmailgate05.web.de ([217.72.192.243]:64073 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbYIKNlt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 09:41:49 -0400
Received: from web.de
	by fmmailgate05.web.de (Postfix) with SMTP id 02ADE591C343
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 15:41:48 +0200 (CEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I have a problem with my toolchain.

I am using codesourcery lite in /opt/cs ...
The omap kernel is in /opt/src/2.6-kernel ...

I try to compile some test programm for gpio testing of EVM board  .. #=
include <asm/arch/gpio.h>

Since this gpio.h is not part of cs I tried to compile with -I option a=
s below:

gcca -o gpio -I /opt/src/2.6_kernel/include/ gpio.c
In file included from /opt/src/2.6_kernel/include/asm/arch/hardware.h:4=
4,
                 from /opt/src/2.6_kernel/include/asm/hardware.h:16,
                 from /opt/src/2.6_kernel/include/asm/arch/gpio.h:29,
                 from gpio.c:6:
/opt/src/2.6_kernel/include/asm/arch/io.h:185: error: expected ':', ','=
, ';', '}' or '__attribute__' before 'offset'
/opt/src/2.6_kernel/include/asm/arch/io.h:191: error: expected ':', ','=
, ';', '}' or '__attribute__' before 'offset'

What am I do wrong? I guess my toolchain is not done well, but I don't =
know how to do it better. Someone can help?

*gcca is a link to arm-none.../bin/....gcc
_______________________________________________________________________=
_
Schon geh=F6rt? Bei WEB.DE gibt' s viele kostenlose Spiele:
http://games.entertainment.web.de/de/entertainment/games/free/index.htm=
l

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
