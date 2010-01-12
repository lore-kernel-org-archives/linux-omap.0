From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/3] OMAP: omap_device: optionally auto-adjust device activate/deactivate latencies
Date: Mon, 11 Jan 2010 17:07:24 -0800
Message-ID: <87tyusi10z.fsf@deeprootsystems.com>
References: <1262993213-19866-1-git-send-email-khilman@deeprootsystems.com>
	<1262993213-19866-2-git-send-email-khilman@deeprootsystems.com>
	<4B489B1A.8040609@gmail.com> <871vhwjgdp.fsf@deeprootsystems.com>
	<4B4BC9E9.5000903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:51853 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932Ab0ALBH1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 20:07:27 -0500
Received: by ywh6 with SMTP id 6so22024464ywh.4
        for <linux-omap@vger.kernel.org>; Mon, 11 Jan 2010 17:07:26 -0800 (PST)
In-Reply-To: <4B4BC9E9.5000903@ti.com> (Nishanth Menon's message of "Mon\, 11 Jan 2010 19\:01\:29 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Nishanth Menon <menon.nishanth@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>

Nishanth Menon <nm@ti.com> writes:

[...]

>>> nitpick: I think you need {} for the else part too now a days..
>>
>> you mean as a CodingStyle issue, or a compiler issue?
>> do you have a reference for this requirement? 
>>
>> do you mean if the 'if' part has {}, the else part should too, even if
>> it's a single line?
>>
>> I don't really care one way or the other, just want to know more about
>> what you're suggesting.
> Apologies on the obscure comment. I meant Coding style.
> Documentation/CodingStyle says:
>
>  171 This does not apply if one branch of a conditional statement is a
> single
>  172 statement. Use braces in both branches.
>  173
>  174 if (condition) {
>  175         do_this();
>  176         do_that();
>  177 } else {
>  178         otherwise();
>  179 }

doh, looks like I should've RTFM.

Thanks for the pointer.

Kevin

