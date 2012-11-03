From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC PATCH 0/6] ARM: OMAP3+: move smartreflex-class3.c to drivers/power/avs
Date: Sat, 3 Nov 2012 15:44:31 +0100
Message-ID: <CAORVsuWNuRxFm2q7MU5E1P6YCvTMmkFWdBr514-D0R7DZDXv8A@mail.gmail.com>
References: <1351028641-20832-1-git-send-email-nm@ti.com>
	<CAORVsuV9tLQCf+higF4kj4dz==T5Ja6Z++s2byDmUjdNsZTC5A@mail.gmail.com>
	<509518C1.5090204@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55127 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab2KCOoc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 10:44:32 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so6244060iea.19
        for <linux-omap@vger.kernel.org>; Sat, 03 Nov 2012 07:44:31 -0700 (PDT)
In-Reply-To: <509518C1.5090204@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, l-o <linux-omap@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>, J Keerthy <j-keerthy@ti.com>

Hi Nishant,

On Sat, Nov 3, 2012 at 2:14 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Hi Nishanth,
>
>
> On 10/25/2012 09:21 AM, Jean Pihet wrote:
>>
>> Hi Nishant,
>>
>> On Tue, Oct 23, 2012 at 11:43 PM, Nishanth Menon <nm@ti.com> wrote:
>>>
>>> smartreflex.c now resides in drivers/power/avs directory, but class
>>> driver
>>> is in mach-omap2. High time we move it off to drivers/power/avs.
>>
>> Great to see the SR fully moved to drivers/.
>>
>> After review of the code I am OK with the changes besides remarks sent
>> on the patches:
>> Acked-by: Jean Pihet <j-pihet@ti.com>
>>
>> I let Kevin comment on the VC/VP aspect though.
>>
>
> This move looks good to me.  Thanks!
>
> Just had one nit, but after that.  Feel free to post without the RFC, and be
> sure to
> include Rafael and linux-pm since it's moving to drivers/power.
Please also include Anton, cf.
http://marc.info/?l=linux-pm&m=134424298230568&w=2

Regards,
Jean

> I'll then
> queue it
> up for Rafael for v3.8.
>
> Thanks,
>
> Kevin
