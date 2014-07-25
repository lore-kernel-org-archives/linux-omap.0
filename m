From: Hannes Petermaier <Hannes.Petermaier@br-automation.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: am335x-bone: add support for beaglebone LCD4
 cape
Date: Fri, 25 Jul 2014 12:53:23 +0200
Message-ID: <OF7172B336.27CEF409-ONC1257D20.003BCA0E-C1257D20.003BD1C2@br-automation.com>
References: <1406284444-16733-1-git-send-email-pekon@ti.com> <1406284444-16733-4-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail2.br-automation.com ([213.33.116.61]:59416 "EHLO
	mail2.br-automation.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759993AbaGYKxY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jul 2014 06:53:24 -0400
In-Reply-To: <1406284444-16733-4-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Javier Martinez Canillas <javier@dowhile0.org>, linux-mtd <linux-mtd@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, linux-omap-owner@vger.kernel.org, Pekon Gupta <pekon@ti.com>, Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>

sorry - send it again, because i'm not sure about mailinglist-server takes 
"Antwort: ..." within the subject.

Hi Pekon,

i've a question about your display timings:

> +      display-timings {
> +         native-mode = <&timing0>;
> +         /* www.newhavendisplay.com/app_notes/OTA5180A.pdf */
> +         timing0: 480x272 {
> +            clock-frequency = <92000000>;

did you ever test this ? clock frequency is here defined with 92MHz, 
datasheet from the link above says to setup 9MHz. Is there eventually one 
zero much ?

best regards,
Hannes



