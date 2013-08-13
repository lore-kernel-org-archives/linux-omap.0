From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCHv3 0/9] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Tue, 13 Aug 2013 17:51:38 +0200
Message-ID: <520A560A.80609@gmail.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com> <52077B26.1010103@gmail.com> <5209307F.9000701@ti.com> <520A28E5.9030304@gmail.com> <520A51B0.3010805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:48152 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758563Ab3HMPvq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Aug 2013 11:51:46 -0400
Received: by mail-bk0-f43.google.com with SMTP id mz13so2391289bkb.16
        for <linux-omap@vger.kernel.org>; Tue, 13 Aug 2013 08:51:45 -0700 (PDT)
In-Reply-To: <520A51B0.3010805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>

On 13.08.2013 17:33, Dave Gerlach wrote:
> On 08/13/2013 07:39 AM, Daniel Mack wrote:

>> ... but traffic on UART0 won't cause a resume.
>>
> 
> It looks like you are using no_console_suspend? UART0 does not work as a 
> wakeup source with this option set.

Meh. Sorry, I didn't think about that possibility. Indeed, without that
option, it does resume. Now I can search for the reason why other wakeup
sources won't work yet, but that shouldn't bother you.


Thanks again,
Daniel

