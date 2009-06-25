From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH v2] serial: 8250: add IRQ trigger support
Date: Thu, 25 Jun 2009 18:49:16 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F546274F@dbde02.ent.ti.com>
References: <1245712519-18259-1-git-send-email-vikram.pandita@ti.com>
 <20090624170959.2dd83c98@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50517 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbZFYNTi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 09:19:38 -0400
In-Reply-To: <20090624170959.2dd83c98@lxorguk.ukuu.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "maz@misterjones.org" <maz@misterjones.org>


>-----Original Message-----
>From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
>Subject: Re: [PATCH v2] serial: 8250: add IRQ trigger support
>
>On Mon, 22 Jun 2009 18:15:19 -0500
>Vikram Pandita <vikram.pandita@ti.com> wrote:
>
>> There is currently no provision for passing IRQ trigger flags for
>> serial IRQs with triggering requirements (such as GPIO IRQs)
>>
>> This patch adds irqflags to plat_serial8250_port that can be passed
>> from board file to reqest_irq() of 8250 driver
>
>Queued

Thanks Alan for queueuing up the 8250 irq trigger patch.
For OMAP Zoom2 board and some other boards needed this real bad.


