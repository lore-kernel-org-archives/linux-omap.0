From: Daniel Mack <zonque@gmail.com>
Subject: Re: Trouble with newer kernels on Gumstix Overo boards
Date: Tue, 21 Jun 2011 10:20:06 +0200
Message-ID: <BANLkTim5H3340RChbaVUOpSYb4tQr9X9YA@mail.gmail.com>
References: <BANLkTimJTBpj30EKf_EucvOf2yCHHbRrkQ@mail.gmail.com>
	<ADF30F4D7BDE934D9B632CE7D5C7ACA4047B99E7E7AD@dbde03.ent.ti.com>
	<BANLkTimfeS1Xin779eg=8cdjqmqcQeB6HA@mail.gmail.com>
	<20110621072220.GA21159@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:55552 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab1FUIUH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jun 2011 04:20:07 -0400
Received: by pzk26 with SMTP id 26so4361203pzk.10
        for <linux-omap@vger.kernel.org>; Tue, 21 Jun 2011 01:20:06 -0700 (PDT)
In-Reply-To: <20110621072220.GA21159@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jun 21, 2011 at 9:22 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Daniel Mack <zonque@gmail.com> [110617 18:06]:
>> On Fri, Jun 17, 2011 at 4:03 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
>> >> console=ttyS2,115200 root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait
>> >
>> > Here is your problem. We now use the OMAP-serial driver for the UARTs.
>>
>> Which breaks backward-compatibility with bootloaders set up for older
>> kernels. Now I have to deploy kernels with CONFIG_CMDLINE_FORCE=y. Was
>> that really necessary?
>
> In most cases you can just setenv cmdline then saveenv in u-boot.

Well, it doesn't really affect me as I just use this as a development
platform for now. But please consider that there is hardware out there
which gets software updates through automated download and install
procedures. In such cases, you want as little dependencies between the
bootloader and the kernel, so you can boot both older and newer
kernels (and full software distribution images) with no pain. Or maybe
quickly switch from one version to the other for testing. Depending on
the complexity of the system, the bootloader might also add extra
parameters to the cmdline dynamically.

The serial console change breaks this approach, at it forces the
kernel to ship its own CMDLINE and override the one the bootloader
provides. I'm sure this is a problem that affects people out there.


Daniel
