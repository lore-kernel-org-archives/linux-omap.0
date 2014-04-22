From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] ARM: dts: am437x-gp-evm: Boot fixes
Date: Tue, 22 Apr 2014 14:53:18 -0500
Message-ID: <5356C8AE.3090907@ti.com>
References: <1398192739-8901-1-git-send-email-d-gerlach@ti.com> <20140422190132.GA12204@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57452 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756639AbaDVTxn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 15:53:43 -0400
In-Reply-To: <20140422190132.GA12204@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, bcousson@baylibre.com, Sekhar Nori <nsekhar@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>

On 04/22/2014 02:01 PM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [140422 11:52]:
>> This patch, along with patch here [1], fixes boot for am437x-gp-evm. The
>> bootloader configures gpio5_7 to control the DDR3 termination regulator,
>> the linked patch prevents that gpio bank from being reset and losing
>> the previously configured state, and this patch binds the gpio to a
>> regulator so the kernel is aware of the state of the gpio.
>>
>> [1] https://www.mail-archive.com/linux-omap@vger.kernel.org/msg102941.html
>
> Setting up the GPIO regulator makes sense to me. But the hack in the
> link above is potentially a nasty time bomb for anybody trying to
> use GPIO bank 5 on that board.
>
> What tests have been done that the GPIO bank behaves properly when
> it's not reset?

We've been using this configuration on this board for a while without 
any apparent issues. Also, am335x-evmsk already uses the same idea for 
the VTT regulator on board from commit 
6046adb6ad701026c10adeac8d6a4138895f12e5 [ARM: dts: am335x-evmsk: Do not 
reset gpio0] and I am unaware of any issues with that either.

Regards,
Dave

>
> Regards,
>
> Tony
>

