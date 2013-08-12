From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCHv3 0/9] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Mon, 12 Aug 2013 13:59:11 -0500
Message-ID: <5209307F.9000701@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com> <52077B26.1010103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54530 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106Ab3HLS7i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Aug 2013 14:59:38 -0400
In-Reply-To: <52077B26.1010103@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>

On 08/11/2013 06:53 AM, Daniel Mack wrote:
> Hi Dave,
>
> Thanks a lot for your work on this.
>
> On 06.08.2013 19:49, Dave Gerlach wrote:
>> This is the third version of the patch series for adding basic suspend-resume
>> support for AM33XX, previously submitted by Vaibhav Bedia. This patchset
>> is based on 3.11-rc4 and depends on a forthcoming patchset from Suman Anna
>> that adds mailbox support for the wkup_m3. The patches at [1], [2], and [3] are
>> required for the pm code to properly suspend and resume.
>
> I applied your set and the one from Suman Anna, and with musb disabled
> and the firmware built from the sources you referenced, I'm able to put
> a custom AM33xx based board to suspend.
>
> The problem I currently face is that I can't make the board resume, as
> neither UART0 nor GPIO0 seem to work as wakeup source.

Did you apply the other patches that are mentioned besides Suman's 
series? The board will hang while suspending without these.

>
> Which wakeup source did you use in your tests?
>

Most of my verification was done with UART wakeup.

>
> Thanks,
> Daniel
>


