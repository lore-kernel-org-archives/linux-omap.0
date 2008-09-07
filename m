From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: musb broken, was [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Sun, 7 Sep 2008 11:08:49 -0700
Message-ID: <5e088bd90809071108i3bc9602epc116525a5a62b1ad@mail.gmail.com>
References: <5e088bd90809061449l5b9d2d2dm1920301b70e6e5bf@mail.gmail.com>
	 <200809062223.10845.david-b@pacbell.net>
	 <yw1xsksc7zm1.fsf@thrashbarg.mansr.com>
	 <200809071037.40094.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:58739 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108AbYIGSIu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Sep 2008 14:08:50 -0400
Received: by py-out-1112.google.com with SMTP id p76so626724pyb.10
        for <linux-omap@vger.kernel.org>; Sun, 07 Sep 2008 11:08:49 -0700 (PDT)
In-Reply-To: <200809071037.40094.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, linux-omap@vger.kernel.org

On Sun, Sep 7, 2008 at 10:37 AM, David Brownell <david-b@pacbell.net> w=
rote:
> On Sunday 07 September 2008, M=E5ns Rullg=E5rd wrote:
>> I've also had to revert the "usb: musb: pass configuration specifics
>> via pdata" commits:
>>
>>   ffd60d49c70b31d26430a1098edf0eef5e4dfac8 in linux-omap
>>   ca6d1b1333bc2e61e37982de1f28d8604c232414 in mainline
>>
>> I suspect there are simply some tables missing for the Beagle board,
>> but I haven't a clue what should go in them.
>
> Odd, that's in the RC3 code and it works for me.

I don't need to revert those commits on Overo and it works "as well as
it ever has" which means that I get disconnects/reconnects of all
devices at random intervals.  I am using musb in host mode, whereas I
think Mans is in device/gadget mode.

Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
