From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [GIT PULL] omap fixes against v3.12-rc3
Date: Wed, 9 Oct 2013 14:09:01 -0700
Message-ID: <CAGa+x85i5OXA2cNEAT+hZC-c01xq8ZwTbb4kse=Vw9pS6_i1Rw@mail.gmail.com>
References: <20131008220324.GV8313@atomide.com>
	<87d2netbvh.fsf@linaro.org>
	<20131009205127.GF8313@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:54138 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192Ab3JIVJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 17:09:02 -0400
Received: by mail-wi0-f174.google.com with SMTP id cb5so1201292wib.13
        for <linux-omap@vger.kernel.org>; Wed, 09 Oct 2013 14:09:01 -0700 (PDT)
In-Reply-To: <20131009205127.GF8313@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "arm@kernel.org" <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Oct 9, 2013 at 1:51 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Kevin Hilman <khilman@linaro.org> [131009 13:50]:
>>
>> FWIW, my automated boot is doing only DT boots on all the OMAP
>> platforms.  However, it's only testing basic boot so far so there's not
>> a whole lot of driver testing yet (but it's coming soon.)
>
> OK cool. For omap3, off-idle with DT needs the pending
> pinctrl-single patches, and some yet unknown way of mapping
> wake-up events to device interrupts. But after that you
> can also do some PM related tests potentially :)

Yeah, a review/test of that series is already my TODO list.

Kevin
