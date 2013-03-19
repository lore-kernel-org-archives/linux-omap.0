From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 0/5] usb: musb: am335x support
Date: Tue, 19 Mar 2013 14:27:37 +0100
Message-ID: <87620nwmd2.fsf@dell.be.48ers.dk>
References: <cover.1351870620.git.afzal@ti.com> <509420D8.1030307@gmail.com>
	<C8443D0743D26F4388EA172BF4E2A7A93EA0A1F2@DBDE01.ent.ti.com>
	<51312430.6060306@gmail.com> <87sj4cunp6.fsf@dell.be.48ers.dk>
	<5133E268.5010604@gmail.com> <51388D64.9000005@gmail.com>
	<513A1580.90303@gmail.com> <514863BD.5010503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:46786 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633Ab3CSN1m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Mar 2013 09:27:42 -0400
In-Reply-To: <514863BD.5010503@gmail.com> (Daniel Mack's message of "Tue, 19
	Mar 2013 14:10:21 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "Balbi, Felipe" <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, "Santhapuri, Damodar" <damodar.santhapuri@ti.com>, "B, Ravi" <ravibabu@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>, Kishon Vijay Abraham I <kishon@ti.com>

>>>>> "Daniel" == Daniel Mack <zonque@gmail.com> writes:

Hi,

 >> I know this patch reintroduces bits that have been intentionally
 >> removed before, in particular by 032ec49f53 ("usb: musb: drop
 >> useless board_mode usage"), but I don't know how this usb driver is
 >> supposed to work in host mode without taking the configured port
 >> mode into account. If anyone can explain to me which information I'm
 >> missing here, I can happily test a patch. For now, this works for
 >> me.

 Daniel> Hmm, nobody, really? Am I the only one who's running the musb
 Daniel> driver in host-only mode?

Sorry, I'll be needing host mode as well, but am currently stuck working
on non-am335x stuff - So I'm definately interested in getting it to
work, but don't have free cycles to look into it right now.

-- 
Bye, Peter Korsgaard
