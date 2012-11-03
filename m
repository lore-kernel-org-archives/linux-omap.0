From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC PATCH 0/6] ARM: OMAP3+: move smartreflex-class3.c to drivers/power/avs
Date: Sat, 03 Nov 2012 13:14:41 +0000
Message-ID: <509518C1.5090204@deeprootsystems.com>
References: <1351028641-20832-1-git-send-email-nm@ti.com> <CAORVsuV9tLQCf+higF4kj4dz==T5Ja6Z++s2byDmUjdNsZTC5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:40643 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab2KCNOm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Nov 2012 09:14:42 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so2002859wib.1
        for <linux-omap@vger.kernel.org>; Sat, 03 Nov 2012 06:14:41 -0700 (PDT)
In-Reply-To: <CAORVsuV9tLQCf+higF4kj4dz==T5Ja6Z++s2byDmUjdNsZTC5A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, l-o <linux-omap@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>, J Keerthy <j-keerthy@ti.com>

Hi Nishanth,

On 10/25/2012 09:21 AM, Jean Pihet wrote:
> Hi Nishant,
>
> On Tue, Oct 23, 2012 at 11:43 PM, Nishanth Menon <nm@ti.com> wrote:
>> smartreflex.c now resides in drivers/power/avs directory, but class driver
>> is in mach-omap2. High time we move it off to drivers/power/avs.
> Great to see the SR fully moved to drivers/.
>
> After review of the code I am OK with the changes besides remarks sent
> on the patches:
> Acked-by: Jean Pihet <j-pihet@ti.com>
>
> I let Kevin comment on the VC/VP aspect though.
>

This move looks good to me.  Thanks!

Just had one nit, but after that.  Feel free to post without the RFC, 
and be sure to
include Rafael and linux-pm since it's moving to drivers/power.  I'll 
then queue it
up for Rafael for v3.8.

Thanks,

Kevin
