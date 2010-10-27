From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/5] omap: mailbox: fix detection for previously supported chips
Date: Wed, 27 Oct 2010 12:46:16 +0300
Message-ID: <AANLkTinDVL3_7cT6YVtn=4dPT-fW78U=kYxdALZMDSuB@mail.gmail.com>
References: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
	<1288129984-22957-5-git-send-email-omar.ramirez@ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030D3105B2@dbde02.ent.ti.com>
	<AANLkTimvapU3w6BzM4MLawEjkohAT+yOrg6kdGj8fLkg@mail.gmail.com>
	<AANLkTimaeoLdUK=0zzk37GZf0TWLRR4=AjKO8EkD72g-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32896 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377Ab0J0JqS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Oct 2010 05:46:18 -0400
Received: by fxm16 with SMTP id 16so494815fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Oct 2010 02:46:16 -0700 (PDT)
In-Reply-To: <AANLkTimaeoLdUK=0zzk37GZf0TWLRR4=AjKO8EkD72g-@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Anna, Suman" <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Oct 27, 2010 at 12:00 PM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> On Wed, Oct 27, 2010 at 10:28 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Wed, Oct 27, 2010 at 8:06 AM, Varadarajan, Charulatha <charu@ti.com> wrote:
>>>
>>> Use cpu_is_* check only. No need to have #if CONFIG_ARCH_* checks.
>>
>> Some people conditionally compile only for one architecture, like in
>> consumer devices. There's no point in wasting space for that.
>
> And cpu_is_* calls become constants in such cases, allowing compiler
> to optimize away unneeded 'if' blocks, not to mention cpu_is_* allows
> multi-omap support. cpu_is_* is the way to go.

The problem is not the cpu_is_* calls, the problem is what is inside
them (e.g. omap3_mboxes). If CONFIG_ARCH_OMAP3 is not defined, then
compilation would be broken, unless you always include all the arrays.

Multi-omap support is already there, because it means
CONFIG_ARCH_OMAP3, CONFIG_ARCH_OMAP2, etc.

-- 
Felipe Contreras
