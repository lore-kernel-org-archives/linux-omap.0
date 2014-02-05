From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: hwmod: Fix SOFTRESET logic for OMAP4
Date: Wed, 5 Feb 2014 11:41:31 -0600
Message-ID: <CAGo_u6qt2qqsxRSdJM26g6_UHObTQQTyPin0fU_1fOViAqW8Lg@mail.gmail.com>
References: <1391612769-27890-1-git-send-email-illia.smyrnov@globallogic.com>
	<52F26F53.20408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52F26F53.20408@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Dan Murphy <dmurphy@ti.com>
Cc: Illia Smyrnov <illia.smyrnov@globallogic.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Roger Quadros <rogerq@ti.com>, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

2014-02-05 Grygorii Strashko <grygorii.strashko@ti.com>:
> Hi All,
> On 02/05/2014 05:06 PM, Illia Smyrnov wrote:
>> Commit 313a76e (ARM: OMAP2+: hwmod: Fix SOFTRESET logic) introduced
>> softreset bit cleaning right after set one. It is caused L3 error for
>> OMAP4 ISS because ISS register write occurs when ISS reset process is in
>> progress. Avoid this situation by cleaning softreset bit later, when reset
>> process is successfully finished.
>
> I'd like to mention that this issue has been caught while upgrading
> custom Linux Kernel 3.4 to the last Stable Kernel linux-3.4.y.
> So, the same OMAP4+ functionality can be broken in all Stable trees
> where commit "ARM: OMAP2+: hwmod: Fix SOFTRESET logic" was merged to.
>
> On OMAP4+ we should always try to wait until IP reset is finished before proceed.
>
> Reviewed-by: "Grygorii Strashko <grygorii.strashko@ti.com>"
>
> Error log example (k3.4):
>

Thanks - I for a moment thought it was on newer kernels :).

Looping in Dan who is currently looking at reset driver replacement
for existing hwmod based reset solution.

Regards,
Nishanth Menon
