From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] perf: export power_start and power_end tracepoints
Date: Fri, 13 May 2011 17:09:12 +0200
Message-ID: <BANLkTikkd9bNRLF1iDAz9Jwrnon3A=j44g@mail.gmail.com>
References: <1305297838-4015-1-git-send-email-j-pihet@ti.com>
	<20110513144830.GB32688@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110513144830.GB32688@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-omap@vger.kernel.org

Adding l-o and linux-pm MLs. The original post is at
http://www.spinics.net/lists/kernel/msg1186554.html

On Fri, May 13, 2011 at 4:48 PM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * jean.pihet@newoldbits.com <jean.pihet@newoldbits.com> wrote:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> If used in a module both tracepoints need to be exported by the
>> kernel.
>
> but it's not used by any module in the kernel AFAICS, so why is this =
needed?
Not currently, that is why the error went unnoticed. I think it is
better to fix it now than later.

I am working on a plan to clean-up and isolate the OMAP PM code from
the core code and to provide the PM functionality as a module. This
effort is part of the 'remove the crazy ARM churn' from the kernel.

Thanks,
Jean

>
> Thanks,
>
> =A0 =A0 =A0 =A0Ingo
>
