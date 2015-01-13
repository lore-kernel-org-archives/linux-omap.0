From: Amit Virdi <amit.virdi-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 2/4] usb: dwc3: gadget: Stop TRB preparation after limit
 is reached
Date: Tue, 13 Jan 2015 10:18:20 +0530
Message-ID: <54B4A394.5060005@st.com>
References: <cover.1418972323.git.amit.virdi@st.com> <995bc6a5f9abd9a41f7229aafd1c2978b526783b.1418972323.git.amit.virdi@st.com> <20141222160626.GD12815@saruman> <CAEOkp44o-a1Onxwxp6rRZvN+vgWhALiNf=Z5FbRtyrOW2JWx=Q@mail.gmail.com> <20141227174628.GB17608@saruman> <CAEOkp447UBzCRfmCO1yy1_k4N40L_TsfbrCpoLXd=Wmav8JROg@mail.gmail.com> <20141229171232.GI29379@saruman> <CAEOkp466i87H2cRkG+GopsiqamV6Ym=Rm5Lbiqc2pk29X0Rt=w@mail.gmail.com> <20141230160215.GB415@saruman> <54AB7D3F.3030809@st.com> <20150112183459.GK6525@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150112183459.GK6525@saruman>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>
Cc: Amit Virdi <amitvi128-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pratyush Anand Thakur <pratyush.anand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ajay KHANDELWAL <ajay.khandelwal-qxv4g6HH51o@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 1/13/2015 12:04 AM, Felipe Balbi wrote:
> Hi,
>
> On Tue, Jan 06, 2015 at 11:44:23AM +0530, Amit Virdi wrote:
>>>>>> I can certainly provide the dwc3 specific kernel bootup logs, full
>>>>>> regdump and any loglevel you want me to, if that helps
>>>>>
>>>>> Yeah, if you can provide those, then that'll help me verifying. Full
>>>>> logs from boot to failure point with VERBOSE_DEBUG enabled (considering
>>>>> you're not running on anything recent).
>>>>>
>>>>
>>>> Okay. I'll provide full verbose logs, along with the register dump,
>>>> when I'm back to the office next week, for the working and non-working
>>>> case, but how - as attachment or as inline?
>>>
>>> Either way will do but I have a feeling mailing list attachment size
>>> will bite you, so maybe it's best to make a tarball of both logs and
>>> send that as attachment. Compressed text will be very small.
>>>
>>
>> Attached are the dwc3 verbose logs and register dump without and with the
>> fixes in this patchset.
>
> Sorry for the long delay, it has been a bit hectic.
>

It's okay!

> I can see from your logs that we end up with a Transfer Not Ready
> (Transfer Active) event and endpoint has BUSY flag set. I also see that
> you're queueing 31 requests and all of them will use 2 TRBs, so we
> clearly go over our TRB table.
>
> This fix is, indeed, necessary but we need to improve commit log a bit
> so it's extremely clear what the error is. Later, we can improve how we
> handle requests in this driver, but that is outside of the scope of your
> patchset.
>
> Please improve commit log and resend your series so it can be applied.
>

Alright! I'll improve the commit messages and, also, cc stable list 
while resending the patches. As I see, you have already picked patches 
[3/4] and [4/4]. So, I'll resend only [1/4] and [2/4]

> cheers
>

Thank you for your patience and kind understanding.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
