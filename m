From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC/PATCH 0/2] omap: mailbox: hwmod experiment
Date: Mon, 24 May 2010 17:02:09 -0700
Message-ID: <87vdacu9vi.fsf@deeprootsystems.com>
References: <1274549122-26521-1-git-send-email-felipe.contreras@gmail.com>
	<AANLkTimiCIA7Bx3mWcFBl6UMWSYMEEufDkAUcidnQ_i_@mail.gmail.com>
	<AANLkTimci9dfIUXNpLb32r_Hbk2KegnVZnNKvr-3V2j9@mail.gmail.com>
	<AANLkTikrjWVfK69M4f22dmYapXZk0tPwD4NGzpmmsFJj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60453 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932281Ab0EYACM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 May 2010 20:02:12 -0400
Received: by pwi2 with SMTP id 2so767186pwi.19
        for <linux-omap@vger.kernel.org>; Mon, 24 May 2010 17:02:11 -0700 (PDT)
In-Reply-To: <AANLkTikrjWVfK69M4f22dmYapXZk0tPwD4NGzpmmsFJj@mail.gmail.com> (Ohad Ben-Cohen's message of "Mon\, 24 May 2010 22\:55\:28 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Paul Walmsley <paul@pwsan.com>

Ohad Ben-Cohen <ohad@wizery.com> writes:

> On Mon, May 24, 2010 at 10:33 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Mon, May 24, 2010 at 8:29 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>>> On Sat, May 22, 2010 at 8:25 PM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> I played a bit with omap_hwmod/omap_device for the mailbox, and this is the
>>>> result.
>>>
>>> Nice move Felipe :)
>>
>> Thanks :)
>>
>>> Can you convert this to use the runtime PM layer, instead of directly
>>> calling omap_device functions via pdata ?
>>
>> Well, I didn't see anybody using omap_device, so I just assumed from
>> reading the code.
>>
>> Recently I saw some patches using this pm_runtime stuff, but it seems
>> to be for some pm branch... not sure which one.
>
> check out pm-wip/mmc on
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
> :)

Agreed, using runtime PM, you no longer need to call omap_device
functions directly.

As pointed out by Ohad, the pm-wip/mmc branch has an example
conversion of the MMC driver with this approach.

Kevin
