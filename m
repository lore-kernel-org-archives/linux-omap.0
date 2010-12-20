From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 1/2] I2C: i2c-omap: Change device name: i2c_omap -> omap_i2c
Date: Mon, 20 Dec 2010 08:07:36 -0800
Message-ID: <87oc8g5sxj.fsf@deeprootsystems.com>
References: <1291904657-32729-1-git-send-email-b-cousson@ti.com>
	<1291904657-32729-2-git-send-email-b-cousson@ti.com>
	<878vzydgxr.fsf@deeprootsystems.com>
	<20101209190110.GR20097@trinity.fluff.org>
	<87wrni7jys.fsf@deeprootsystems.com>
	<BC214410FD04D84F9079A6242365970707D4FA@008-AM1MPN1-001.mgdnok.nokia.com>
	<4D01E4B5.1010703@ti.com> <20101218015507.GL5941@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:35146 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757900Ab0LTQHl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 11:07:41 -0500
Received: by gxk19 with SMTP id 19so1715441gxk.11
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 08:07:41 -0800 (PST)
In-Reply-To: <20101218015507.GL5941@atomide.com> (Tony Lindgren's message of
	"Fri, 17 Dec 2010 17:55:07 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "aaro.koskinen@nokia.com" <aaro.koskinen@nokia.com>, "ben-i2c@fluff.org" <ben-i2c@fluff.org>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nayak, Rajendra" <rnayak@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * Cousson, Benoit <b-cousson@ti.com> [101210 00:29]:
>> On 12/9/2010 11:18 PM, aaro.koskinen@nokia.com wrote:
>> >Hi,
>> >
>> >Kevin Hilman [khilman@deeprootsystems.com]:
>> >>Ben Dooks<ben-i2c@fluff.org>  writes:
>> >>>Renaming stuff like this is going to have an impact on the userspace
>> >>>as anyone looking through /sys's driver heirarchy is going to miss the
>> >>>old name...
>> >>>
>> >>>It all depends if you really want to go ahead with this...
>> >>
>> >>Yes, we are aware of the userspace impact, but this name change makes
>> >>all devices on OMAP have consistent names and actually improves the
>> >>ability to have userspace tools have consistent naming as well.
>> >
>> >So there are no imporant users, or if there is, they are prepared for this change?
>> 
>> Well, I do not know any user of that today. Do you have some in mind?
>
> Sounds like it's safe for me to take these two.

These should probably go via Paul's integration branch to avoid
conflicts with the other omap_device/omap_hwmod code.

Kevin

