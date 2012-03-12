From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v3 00/13] gpio/omap: Some more driver cleanup and fixes
Date: Tue, 13 Mar 2012 01:57:03 +0530
Message-ID: <CAC83ZvJDfDBcRU1isYaxRe-fWN8F2+QW6W5EeWWuTRcFBGpYNg@mail.gmail.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
	<878vj5y7iv.fsf@ti.com>
	<CAC83Zv+8AjCHBOJbtvSQS-URvCE5Xm9oPk9_X7h4Kz7FZ_7Otw@mail.gmail.com>
	<CAC83ZvJKS34Py6vVtk_Si9q3A-9CVN6v4ixNM+HJ37AATcGNPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob129.obsmtp.com ([74.125.149.136]:49979 "EHLO
	na3sys009amx259.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757244Ab2CLU1F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 16:27:05 -0400
Received: by mail-gx0-f176.google.com with SMTP id s6so3523436ggc.7
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 13:27:03 -0700 (PDT)
In-Reply-To: <CAC83ZvJKS34Py6vVtk_Si9q3A-9CVN6v4ixNM+HJ37AATcGNPA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Tue, Mar 13, 2012 at 1:38 AM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
> On Tue, Mar 13, 2012 at 1:23 AM, DebBarma, Tarun Kanti
> <tarun.kanti@ti.com> wrote:
>> On Tue, Mar 13, 2012 at 12:24 AM, Kevin Hilman <khilman@ti.com> wrote:
>>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>>
>>>> The cleanup is mostly getting rid of redundant fields in struct gpio_bank{}
>>>> as we already have them as part of bank->context now. Also, remove un-used
>>>> variable from gpio_irq_handler.
>>>>
>>>> The fixes include correction of _set_gpio_irqenable() implementation,
>>>> missing wakeup_en register update in set_gpio_wakeup(), type mismatch
>>>> of gpio trigger parameter in set_gpio_trigger(), incorrect dataout
>>>> register update in set_gpio_dataout_() and few corrections in context
>>>> save logic.
>>>>
>>>> It is baselined on top of Kevin's following series:
>>>> gpio/omap: cleanup and runtime PM conversion for v3.4
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/gpio/runtime-pm-cleanup
>>>>
>>>> Series is available here for reference:
>>>> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_further_cleanup_fixes
>>>
>>> This branch doesn't exist.
>> Oops... I am sorry.
>> I was in the process of updating the branch with latest comments after
>> base-lining on Grant's:
>> git://git.secretlab.ca/git/linux-2.6.git
>> Branch: gpio/next
>> Because this has all the gpio changes including Benoit's latest gpio
>> devicetree changes.
>> Should I go ahead?
> Anyways, for the time being I am updating on top of your changes as before.
> You should be able to see the branch shortly.
Please note that the branch has your following patch:
gpio/omap: fix wakeups on level-triggered GPIOs
--
Tarun

>>> Kevin
>>>
