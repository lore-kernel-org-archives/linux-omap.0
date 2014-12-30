From: Amit Virdi <amitvi128@gmail.com>
Subject: Re: [PATCH 2/4] usb: dwc3: gadget: Stop TRB preparation after limit
 is reached
Date: Tue, 30 Dec 2014 20:11:13 +0530
Message-ID: <CAEOkp466i87H2cRkG+GopsiqamV6Ym=Rm5Lbiqc2pk29X0Rt=w@mail.gmail.com>
References: <cover.1418972323.git.amit.virdi@st.com>
	<995bc6a5f9abd9a41f7229aafd1c2978b526783b.1418972323.git.amit.virdi@st.com>
	<20141222160626.GD12815@saruman>
	<CAEOkp44o-a1Onxwxp6rRZvN+vgWhALiNf=Z5FbRtyrOW2JWx=Q@mail.gmail.com>
	<20141227174628.GB17608@saruman>
	<CAEOkp447UBzCRfmCO1yy1_k4N40L_TsfbrCpoLXd=Wmav8JROg@mail.gmail.com>
	<20141229171232.GI29379@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:44953 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbaL3OlO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Dec 2014 09:41:14 -0500
In-Reply-To: <20141229171232.GI29379@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Amit Virdi <amit.virdi@st.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, Pratyush Anand Thakur <pratyush.anand@gmail.com>, ajay.khandelwal@st.com

>> The only reason why I have not been able to test these fixes on the
>> latest is because the customized webcam gadget is not ported on the
>> latest kernel. There have been a lot of changes in the video framework
>> lately and that is not my area of expertise. So porting the customized
>> webcam gadget to latest kernel and testing these fixes is not feasible
>> for me.
>
> right, so while I can see that both patches are very minimal and likely
> to be correct, I have no way of guaranteeing that. The only thing I can
> do, is run the tests which I already run (none of which exercise the
> cases you found though, other I'd have found them already) to make sure
> your patches don't break what's already working.
>

Okay

>> Having said all this, the fact remains that these are bugs in the dwc3
>> driver from kernel v3.9 onwards. The log messages clearly depict this.
>
> no, it doesn't :-) your log snippet is so small that I cannot see how
> the driver got to that point :-) The only thing I can see is that you
> started two requests, one for 960000 bytes and another one for 2 bytes,
> but I don't know how many TRBs we had available, nor do I see a Start
> Transfer command, so I can't validate Start Transfer command parameters
> were correct or not.
>
>> These bugs are obviously present till date.
>
> Right, the code is the same :-)
>
>> I ask you to give a more deeper thought on the whole situation and not
>> undermine the importance of code review.
>
> heh
>
>>  - [Patch 2/4] fixes a bug that could have been found in the code review.
>>  - [Patch 1/4] fixes a bug which was very very subtle but a deeper
>> code review can certainly boost the confidence about the change made.
>> list_is_last won't work when SG is used because, for the last request
>> in the request_list, the TRB for the first sg entry modifies the
>> list's next and prev pointers while moving the URB to req_queued.
>>
>> I can certainly provide the dwc3 specific kernel bootup logs, full
>> regdump and any loglevel you want me to, if that helps
>
> Yeah, if you can provide those, then that'll help me verifying. Full
> logs from boot to failure point with VERBOSE_DEBUG enabled (considering
> you're not running on anything recent).
>

Okay. I'll provide full verbose logs, along with the register dump,
when I'm back to the office next week, for the working and non-working
case, but how - as attachment or as inline?
