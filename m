From: Mike Chan <mike@android.com>
Subject: Re: [PATCH v2 1/2] omap: pm34xx: Enable IO / IO-CHAIN wakeups for PER
Date: Mon, 3 May 2010 16:48:21 -0700
Message-ID: <p2q8bb80c381005031648o43f3a724k56feba4780ed06cc@mail.gmail.com>
References: <1272927847-21226-1-git-send-email-mike@android.com>
	 <87tyqor237.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40468 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab0ECXsW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 19:48:22 -0400
Received: by pwj9 with SMTP id 9so1511382pwj.19
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 16:48:21 -0700 (PDT)
In-Reply-To: <87tyqor237.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, r-woodruff2@ti.com, tony@atomide.com

On Mon, May 3, 2010 at 4:35 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Mike Chan <mike@android.com> writes:
>
>> IO events can also come from GPIO modules, which reside in the PER domain.
>> It is possible for the PER to enter RET while CORE is still in ON.
>> If GPIO 2-6 are enabled for IO-pad wakeups, the PER domain will not
>> wakeup in this case, unless we enable it.
>>
>> Signed-off-by: Mike Chan <mike@android.com>
>
> Thanks, adding both patches to PM branch (pm-fixes branch) and will
> queue for 2.6.35.
>

Thanks, with this patch looking good, I was hoping for some feedback
from people on the 2nd patch in the series. It makes sense to me since
PER will be woken up now, not just CORE, but I wanted to double check.

-- Mike

> Kevin
>
