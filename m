From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: musb broken, was [RFC 0/2] McBSP and ASoC OMAP update patches for 2430 and 34xx
Date: Sat, 6 Sep 2008 14:49:35 -0700
Message-ID: <5e088bd90809061449l5b9d2d2dm1920301b70e6e5bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:39078 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbYIFVti (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Sep 2008 17:49:38 -0400
Received: by py-out-1112.google.com with SMTP id p76so519504pyb.10
        for <linux-omap@vger.kernel.org>; Sat, 06 Sep 2008 14:49:36 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Sep 5, 2008 at 10:52 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Steve Sakoman <sakoman@gmail.com> [080905 10:24]:
>> > Hmm, is the musb broken now?
>>
>> It is on Overo if I base my patches against current top of tree
>> (a376251519ced5831ed07ed234430725230ed93a)
>>
>> Doesn't crash, just quietly doesn't work.  I hear from Beagle folk
>> that musb doesn't work there either.   I have it configured as a host
>> port, and IIRC so do the Beagle folks
>>
>> If I base my patches against the state of the tree just prior to the
>> move to rc5 (81c893795c2e1fbe0bf5f638ed6ae1e500b80a2d), musb works as
>> well as it ever has.
>
> Well with -rc5 we switched to the drivers/usb/musb code from mainline
> kernel. Maybe try to diff musb code with:
>
> $ git-diff 81c893795c2e1fbe0bf5f638ed6ae1e500b80a2d.. drivers/usb/musb
>
> And see if there are any clues?

I did that and found that there are very few changes of substance,
mostly formatting and comments.  In fact there were only a few lines
that looked promising at all.

Mans Rullgard has verified that restoring these few lines fixes the
musb issue on beagle (using musb in gadget mode) and I have verified
that it fixes the issue on Overo (which uses musb in host mode).

Mans has a patch in his git:

http://git.mansr.com/?p=linux-omap;a=commitdiff;h=1e5bc41773bb981b3a89bd762becf98c72be5e4c

Neither of us understand musb details enough to propose this as *the*
fix, but it seems likely to be the issue.

Steve
