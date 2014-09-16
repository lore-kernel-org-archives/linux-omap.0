From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 00/16 v9] omap 8250 based uart + DMA
Date: Tue, 16 Sep 2014 14:57:36 +0200
Message-ID: <541833C0.5020106@linutronix.de>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de> <20140912224324.GK18849@atomide.com> <5416D2A0.5020407@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41794 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbaIPM5m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2014 08:57:42 -0400
In-Reply-To: <5416D2A0.5020407@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, gregkh@linuxfoundation.org

On 09/15/2014 01:50 PM, Sebastian Andrzej Siewior wrote:
> I changed the restore function the fix the am335x-evm + less "freeze"=
=2E
> And now we have this. So let me search=E2=80=A6

IER was 0 by accident. It fixed in TX path.
I pushed uart_v10_pre1 which should have it fixed aport from other
things=E2=80=A6
I am going to address the review comments, to split the DMA callbacks
as requested and if nobody comes up with something fancy we will have a
v10 :)

>> Regards,
>>
>> Tony

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
