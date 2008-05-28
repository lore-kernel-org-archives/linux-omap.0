From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 0/4] OMAP3 Beagle: update defconfig to match board file
Date: Wed, 28 May 2008 14:23:16 -0700
Message-ID: <5e088bd90805281423o4a9cfe4r74e60a60e16d4f79@mail.gmail.com>
References: <5e088bd90805272245q4ab6c1aue4b4d7d76e025422@mail.gmail.com>
	 <bf8bea47238577986216c6ae6927cbac@felipebalbi.com>
	 <5e088bd90805280548j10d287cbxe417dfbd85b51a90@mail.gmail.com>
	 <20080528202720.GF8845@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:59553 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbYE1VXS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 17:23:18 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1869962fgg.17
        for <linux-omap@vger.kernel.org>; Wed, 28 May 2008 14:23:16 -0700 (PDT)
In-Reply-To: <20080528202720.GF8845@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <me@felipebalbi.com>

Tony,

I received one piece of feedback offlist.  Since I have to resubmit
one patch, I'll do it as a consolidated patch and make life simpler
for you.

Steve

On Wed, May 28, 2008 at 1:27 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Steve Sakoman <sakoman@gmail.com> [080528 05:49]:
>> What is your preference, Tony?  Would you like me to resubmit as a single patch?
>
> No need to resubmit thanks, although one patch would have been better
> in this case :)
>
> Tony
>
>
>>
>> Steve
>>
>> On Wed, May 28, 2008 at 2:57 AM, Felipe Balbi <me@felipebalbi.com> wrote:
>> >
>> >
>> > On Tue, 27 May 2008 22:45:03 -0700, "Steve Sakoman" <sakoman@gmail.com>
>> > wrote:
>> >> While preparing a set of patches to add nand support for beagle I
>> >> noticed that the beagle defconfig hasn't kept up with the features
>> >> present in board-omap3beagle.c
>> >>
>> >> This series of patches updates the defconfig to enable mmc, rtc, usb, and
>> >> fb
>> >
>> > All of these could come in only one patch.
>> >
>> >
>> > --
>> > Best Regards,
>> >
>> > Felipe Balbi
>> > http://felipebalbi.com
>> > me@felipebalbi.com
>> >
>> >
>
