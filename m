From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: musb broken, was [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Sun, 07 Sep 2008 19:17:47 +0100
Message-ID: <yw1xk5dn95x0.fsf@thrashbarg.mansr.com>
References: <5e088bd90809061449l5b9d2d2dm1920301b70e6e5bf@mail.gmail.com>
	<200809062223.10845.david-b@pacbell.net>
	<yw1xsksc7zm1.fsf@thrashbarg.mansr.com>
	<200809071037.40094.david-b@pacbell.net>
	<5e088bd90809071108i3bc9602epc116525a5a62b1ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from agrajag.mansr.com ([78.86.181.102]:43346 "EHLO mail.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754023AbYIGSYu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Sep 2008 14:24:50 -0400
In-Reply-To: <5e088bd90809071108i3bc9602epc116525a5a62b1ad@mail.gmail.com> (Steve Sakoman's message of "Sun, 7 Sep 2008 11:08:49 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, =?iso-8859-1?Q?M=E5ns_Rullg?= =?iso-8859-1?Q?=E5rd?= <mans@mansr.com>, linux-omap@vger.kernel.org

"Steve Sakoman" <sakoman@gmail.com> writes:

> On Sun, Sep 7, 2008 at 10:37 AM, David Brownell <david-b@pacbell.net>=
 wrote:
>> On Sunday 07 September 2008, M=E5ns Rullg=E5rd wrote:
>>> I've also had to revert the "usb: musb: pass configuration specific=
s
>>> via pdata" commits:
>>>
>>>   ffd60d49c70b31d26430a1098edf0eef5e4dfac8 in linux-omap
>>>   ca6d1b1333bc2e61e37982de1f28d8604c232414 in mainline
>>>
>>> I suspect there are simply some tables missing for the Beagle board=
,
>>> but I haven't a clue what should go in them.
>>
>> Odd, that's in the RC3 code and it works for me.
>
> I don't need to revert those commits on Overo and it works "as well a=
s
> it ever has" which means that I get disconnects/reconnects of all
> devices at random intervals.  I am using musb in host mode, whereas I
> think Mans is in device/gadget mode.

Maybe it started working again.  I know for sure it broke gadget mode
on the Beagle when it first hit linux-omap, and I haven't tried it
since.  Perhaps I should give it another go.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
