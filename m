From: Suresh Rajashekara <suresh.raj+linuxomap@gmail.com>
Subject: Re: [linux-pm] wait_for_completion_interruptible does not wait !!
Date: Sat, 26 Jun 2010 21:08:07 -0700
Message-ID: <AANLkTiktmoiyX4c8x1XtJ353sv0flV5NqIQrptrDXPnM@mail.gmail.com>
References: <AANLkTikPOcNZk5ISX2WDHSmsPDw_a5_3Ic3owAbO4o0y@mail.gmail.com>
	<Pine.LNX.4.44L0.1006201120210.22272-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45416 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707Ab0F0EI1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 27 Jun 2010 00:08:27 -0400
In-Reply-To: <Pine.LNX.4.44L0.1006201120210.22272-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, vivin uthappa <vivinuthappa@gmail.com>, Sudhakar R <sudhakar.raj@gmail.com>

On Sun, Jun 20, 2010 at 8:52 AM, Alan Stern <stern@rowland.harvard.edu>=
 wrote:
>
> What happens if the variable is completed while nobody is waiting for
> it? =A0The next time somebody tries to wait, won't the wait terminate
> immediately?
>

Haven't tested it but will reply with the answer once I get a chance to=
 test it.


>> I tried wait_for_completion instead, but now the kernel refuses to s=
uspend.
>>
>> I have tried wait queues and mutexs with no success.
>>
>> Could anyone please point me how I can resolve this issue? Is there
>> any construct which can block inside the kernel during suspend/resum=
e?
>
> Yes: The freezer.
>
>> Can there be a blocking call active while we suspend?
>
> Yes, in theory. =A0In practice it's not a good idea, since the call
> wouldn't be able to distinguish between an actual signal and the onse=
t
> of a suspend. =A0You might end up with a call that ignores all signal=
s
> and hence cannot be interrupted.
>

Just for the information of others on the list, here is what we did to
solve this issue, we designed a freezer-friendly wrapper around
wait_for_completion_interruptible()

<SNIP>
#define wait_for_completion_freezable(ptr_completion)           \
({                                                              \
   int __retval;                                                \
   do {                                                         \
       __retval =3D wait_for_completion_interruptible(            \
                       ptr_completion);                         \
       if (__retval && !freezing(current))                      \
           break;                                               \
   } while (try_to_freeze());                                   \
   __retval;                                                    \
})

</SNIP>

Thanks
Suresh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
