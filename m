From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP3: disable idle early in the suspend sequence
Date: Mon, 22 Nov 2010 12:38:21 +0100
Message-ID: <AANLkTikJfiJHnbBKWAfWn5xk2SOQiSAvHdjD0p78u4MA@mail.gmail.com>
References: <1290422697-2300-1-git-send-email-j-pihet@ti.com>
	<20101122111105.GZ2446@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56425 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325Ab0KVLiW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 06:38:22 -0500
Received: by qyk12 with SMTP id 12so190615qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 03:38:21 -0800 (PST)
In-Reply-To: <20101122111105.GZ2446@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi,

On Mon, Nov 22, 2010 at 12:11 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Nov 22, 2010 at 11:44:57AM +0100, Jean Pihet wrote:
>>
>> Some bad interaction between the idle and the suspend paths has been
>> noticed: the idle code is called during the suspend enter and exit
>> sequences. This could cause corruption or lock-up of resources.
>>
>> The solution is to move the call to disable_hlt at the very beginning
>> of the suspend sequence (in omap3_pm_begin instead of omap3_pm_prepare),
>> and the call to enable_hlt at the very end of the suspend sequence
>> (in omap3_pm_end instead of omap3_pm_finish).
>>
>> Tested with RET and OFF on Beagle and OMAP3EVM.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>
> This patch will look weird on git log, it's going to be From: Jean Pihet
> <jean.pihet@newoldbits.com> and Signed-off-by: Jean Pihet
> <j-pihet@ti.com>. Maybe you should change user.email variable on your
> .gitconfig and use envelope sender as your newoldbits.com address ?
That is exactly what I am trying to achieve but it does not work ;-(

git config -l shows:
  user.name=Jean Pihet
  user.email=j-pihet@ti.com
  sendemail.smtpuser=jean.pihet@newoldbits.com

The original patch has the ti.com address in both the From: and
Signed-off-by: fields, but the From: on the ML still shows otherwise.
Weird...

Any idea how to fix that?

Thanks!
Jean

>
> --
> balbi
>
