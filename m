From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCHv5 06/15] hwspinlock/omap: enable module before reading
 SYSSTATUS register
Date: Wed, 2 Jul 2014 14:38:04 -0500
Message-ID: <53B45F9C.2040209@ti.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com> <1398904476-26200-7-git-send-email-s-anna@ti.com> <CAK=WgbaKPgLLw-4wCSToE86QrREDB0sK95TLx2y17d71eBPFbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK=WgbaKPgLLw-4wCSToE86QrREDB0sK95TLx2y17d71eBPFbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Josh Cartwright <joshc@codeaurora.org>, Bjorn Andersson <bjorn@kryo.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

On 07/01/2014 07:51 AM, Ohad Ben-Cohen wrote:
> Hi Suman,
> 
> On Thu, May 1, 2014 at 3:34 AM, Suman Anna <s-anna@ti.com> wrote:
>> The number of hwspinlocks are determined based on the value read
>> from the IP block's SYSSTATUS register. However, the module may
>> not be enabled and clocked, and the read may result in a bus error.
>>
>> This particular issue is seen rather easily on AM33XX, since the
>> module wakeup is software controlled, and it is disabled out of
>> reset. Make sure the module is enabled and clocked before reading
>> the SYSSTATUS register.
> 
> This seems like a valid fix that is independent of this patch series.
> 
> Feel free to submit it separately if you want, so we can get it merged.
> 

OK, I will submit this patch and Patch 7 separately.

regards
Suman
