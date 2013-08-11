From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCHv3 0/9] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Sun, 11 Aug 2013 13:53:10 +0200
Message-ID: <52077B26.1010103@gmail.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:64621 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab3HKLxO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Aug 2013 07:53:14 -0400
Received: by mail-ee0-f44.google.com with SMTP id b47so2987153eek.31
        for <linux-omap@vger.kernel.org>; Sun, 11 Aug 2013 04:53:13 -0700 (PDT)
In-Reply-To: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>

Hi Dave,

Thanks a lot for your work on this.

On 06.08.2013 19:49, Dave Gerlach wrote:
> This is the third version of the patch series for adding basic suspend-resume
> support for AM33XX, previously submitted by Vaibhav Bedia. This patchset 
> is based on 3.11-rc4 and depends on a forthcoming patchset from Suman Anna
> that adds mailbox support for the wkup_m3. The patches at [1], [2], and [3] are 
> required for the pm code to properly suspend and resume.

I applied your set and the one from Suman Anna, and with musb disabled
and the firmware built from the sources you referenced, I'm able to put
a custom AM33xx based board to suspend.

The problem I currently face is that I can't make the board resume, as
neither UART0 nor GPIO0 seem to work as wakeup source.

Which wakeup source did you use in your tests?


Thanks,
Daniel

