From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Sun, 28 Aug 2011 00:57:16 +0800
Message-ID: <CACVXFVNz_ic_PPM_vNn1Dz85A2z94kRFso4rcqrvJfuLSqRSCg@mail.gmail.com>
References: <1314456515-16419-1-git-send-email-ming.lei@canonical.com>
	<20110827151317.GA10013@kroah.com>
	<CACVXFVM_p_XPyOOgz7kbEo93SCCxPa4X_vjYGm+fUGMPSFM4EA@mail.gmail.com>
	<20110827160746.GA11076@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:50891 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab1H0Q5S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Aug 2011 12:57:18 -0400
In-Reply-To: <20110827160746.GA11076@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, stern@rowland.harvard.edu, linux-arm-kernel@lists.infradead.org

Hi,

Thanks for your comment.

On Sun, Aug 28, 2011 at 12:07 AM, Greg KH <greg@kroah.com> wrote:

>> As Santosh pointed out, mb on ARM will flush L2 write buffer. The
>> description here is wrong.
>
> Then this can't be accepted as-is :)

Yes, I will update it in v1, :-)

>> I think the below should make the writing reach into memory on all
>> ARCH after ' token =3D dummy->hw_token;' is executed.
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dummy->hw_token =3D t=
oken;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mb()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0token =3D dummy->hw_t=
oken;
>>
>> The above is the idea introduced to fix the problem.
>
> Are you sure? =A0Have you read the documentation about memory barrier=
s to
> confirm this?

I read the doc again, :-), and it mentions few about mb/wmb/rmb, I thin=
k
my above description is still not correct. Generally speaking, mb only
means there is a order between two accesses.

Now I think only one mb() after 'dummy->hw_token =3D token;' is enough:
HC will read the up-to-date value of qtd->hw_token after mb() is execut=
ed
because of the effect of the mb(), which should be guaranteed by mb.

> I mean others, please read the the last 3 lines of the comment and
> compare that to the code lines you added.

I see now, the comment of the last 3 lines is wrong, should be

                        * inside L2 cache. 'token =3D dummy->hw_token'
                         * after mb() is added for obeying correct mb()
                         * usage.

But the 'token =3D dummy->hw_token' after mb() isn't needed any
more as described above,  is it?


thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
