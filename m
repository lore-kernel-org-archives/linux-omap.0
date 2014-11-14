From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCHv6 4/5] hwspinlock/core: add common OF helpers
Date: Fri, 14 Nov 2014 22:05:07 +0200
Message-ID: <CAK=WgbYEQPwPH-i_kfF8-h6uOH9q4rcT1+W0smG3e=chDg833Q@mail.gmail.com>
References: <1410553499-55951-1-git-send-email-s-anna@ti.com>
 <1410553499-55951-5-git-send-email-s-anna@ti.com> <CAK=WgbamdqAufjC4Xb5moERRBSB-cO6c1RPTE=f+dp75F+Eh7A@mail.gmail.com>
 <5463B5B6.8040709@ti.com> <CAK=WgbbatPTiz3efDWHVEcuug_UQfkCViMoK0zcfUg3JwB2oTA@mail.gmail.com>
 <5464EC7A.7050603@ti.com> <CAK=WgbbodS8GsUxQbkyCp6hAG+Ko4LMirx+pUa8_fUdxWFasvw@mail.gmail.com>
 <54651C48.90809@ti.com> <CAK=WgbYMM19-rWLOBjix+TA3fF_Pb25ia1rutDxYSUg9SV0efg@mail.gmail.com>
 <5466373B.2070808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:65383 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161842AbaKNUF2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2014 15:05:28 -0500
Received: by mail-ig0-f173.google.com with SMTP id r10so312995igi.12
        for <linux-omap@vger.kernel.org>; Fri, 14 Nov 2014 12:05:27 -0800 (PST)
In-Reply-To: <5466373B.2070808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Josh Cartwright <joshc@codeaurora.org>, Bjorn Andersson <bjorn@kryo.se>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Fri, Nov 14, 2014 at 7:09 PM, Suman Anna <s-anna@ti.com> wrote:
>> It seems to me that hwspin_lock_request_specific failures should be
>> used by clients to defer their probing. Why wouldn't such a simple
>> solution work?

> Because the API always returns NULL on failures and there is no way for
> the clients to figure out if the lock id passed is invalid or the bank
> containing the lock is not registered.

It seems to me this may always be the case - lock ids may be wrong and
there's no way to fully validate them.

Let's start with the simpler approach where
hwspin_lock_request_specific failures are used by clients to defer
their probing.

If a real use case will require changes we can always do that later,
though it seems to me the only gain by changing this API is to catch a
small subset of fatal DT mistakes which will anyway be caught very
early in the development.

Thanks,
Ohad.
