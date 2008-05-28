From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 0/4] OMAP3 Beagle: update defconfig to match board file
Date: Wed, 28 May 2008 05:48:31 -0700
Message-ID: <5e088bd90805280548j10d287cbxe417dfbd85b51a90@mail.gmail.com>
References: <5e088bd90805272245q4ab6c1aue4b4d7d76e025422@mail.gmail.com>
	 <bf8bea47238577986216c6ae6927cbac@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:24971 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbYE1Msn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 08:48:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1771884fgg.17
        for <linux-omap@vger.kernel.org>; Wed, 28 May 2008 05:48:41 -0700 (PDT)
In-Reply-To: <bf8bea47238577986216c6ae6927cbac@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>

What is your preference, Tony?  Would you like me to resubmit as a single patch?

Steve

On Wed, May 28, 2008 at 2:57 AM, Felipe Balbi <me@felipebalbi.com> wrote:
>
>
> On Tue, 27 May 2008 22:45:03 -0700, "Steve Sakoman" <sakoman@gmail.com>
> wrote:
>> While preparing a set of patches to add nand support for beagle I
>> noticed that the beagle defconfig hasn't kept up with the features
>> present in board-omap3beagle.c
>>
>> This series of patches updates the defconfig to enable mmc, rtc, usb, and
>> fb
>
> All of these could come in only one patch.
>
>
> --
> Best Regards,
>
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
>
>
