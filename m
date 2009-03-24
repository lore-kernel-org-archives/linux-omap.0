From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: tidspbridge git repository
Date: Wed, 25 Mar 2009 01:27:21 +0200
Message-ID: <94a0d4530903241627w2e3a2cb5ibad2bdeee21e5a86@mail.gmail.com>
References: <DDE834F1D8D96540B7373DFF675BF56C110F2E19F0@NOK-EUMSG-03.mgdnok.nokia.com>
	 <20090323194711.GI29546@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:37210 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbZCXX1Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 19:27:24 -0400
Received: by fg-out-1718.google.com with SMTP id 16so639409fgg.17
        for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2009 16:27:21 -0700 (PDT)
In-Reply-To: <20090323194711.GI29546@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: ameya.palande@nokia.com, linux-omap@vger.kernel.org, hiroshi.doyu@nokia.com

On Mon, Mar 23, 2009 at 9:47 PM, Tony Lindgren <tony@atomide.com> wrote:
> * ameya.palande@nokia.com <ameya.palande@nokia.com> [090323 00:42]:
>> Hi Tony,
>>
>> I have collected latest patches for tidspbridge at:
>> git://gitorious.org/tidspbridge/mainline.git
>>
>> Branch is: tidspbridge
>>
>> It is based on your pm branch.
>> Can you pull it to your tidspbridge branch?
>
> What dependencies are there to the PM branch?
>
> To me it sounds like you should rebase your tidspbridge branch
> against the mainline kernel as the drivers should be arch
> independent.
>
> If something is missing from the mainline kernel to rebase and
> compile tidspbridge against the mainline, we need to fix those
> issues.

Last time I tried it worked fine, with one minor issue:
http://github.com/felipec/linux-omap/commit/1ae534c0ab22e57dd986c50adddc83e2ec42f970

Btw, it seems the 2.6.28-omap1 tag didn't have the defconfig updated.

-- 
Felipe Contreras
