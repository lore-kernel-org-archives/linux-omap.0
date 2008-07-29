From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Bluetooth SHUTDOWN GPIO on omap3430 labrador
Date: Tue, 29 Jul 2008 10:27:53 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0256682DCA@dbde02.ent.ti.com>
References: <f502236f0807180250g67fe94e1ue6e9e3485cd71d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:54216 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270AbYG2E6B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2008 00:58:01 -0400
In-Reply-To: <f502236f0807180250g67fe94e1ue6e9e3485cd71d8@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pramod gurav <pramodforum@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Hi All
> I have a omap3430 logic zoom board.
> I want to configure bluetooth on it(BRF6300) which will
> interfaced to UART2.
> I gone through the schematics and could find that the BT_SHUTDOWN is
> controlled through GPIO.8 coming from TWL4030.
> Is that wright? I tried using that GPIO but the hci interface
> did not respond.
> I am using linux-2.6.24 with all bluetooth kernel support.
> What is correct GPIO to BT_SHUTDOWN.

Could you check if the pinmux settings are done correctly?

Tip: Enable CONFIG_OMAP_MUX_DEBUG and you should see all the mux
settings that use the pin-mux API.

Regards,
Anand

>
> Reply is much awaited.
> Thanks for time and consideration.
>
>
> Pramod
