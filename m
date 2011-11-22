From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: HDMI: change the timing match logic
Date: Tue, 22 Nov 2011 18:38:34 +0530
Message-ID: <CAP5A+B-8U38gNCKG-WqNjd7xeWYrBo0xsrZD11_B839ynw4gNA@mail.gmail.com>
References: <1321016977-1808-1-git-send-email-mythripk@ti.com>
 <1321016977-1808-2-git-send-email-mythripk@ti.com> <1321016977-1808-3-git-send-email-mythripk@ti.com>
 <1321016977-1808-4-git-send-email-mythripk@ti.com> <1321255999.1931.18.camel@deskari>
 <CAP5A+B_8fm7unbvb9_=SC62v=3+XFcoOKKA2JOttQugRTPLW8g@mail.gmail.com> <1321600575.1814.14.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:36849 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754858Ab1KVNI4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 08:08:56 -0500
Received: by mail-gy0-f181.google.com with SMTP id r13so148707ghr.12
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 05:08:55 -0800 (PST)
In-Reply-To: <1321600575.1814.14.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Tomi,

On Fri, Nov 18, 2011 at 12:46 PM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> On Wed, 2011-11-16 at 11:01 +0530, K, Mythri P wrote:
>> On Mon, Nov 14, 2011 at 1:03 PM, Tomi Valkeinen <tomi.valkeinen@ti.c=
om> wrote:
>> > On Fri, 2011-11-11 at 18:39 +0530, mythripk@ti.com wrote:
>
>> >> -static int get_timings_index(void)
>> >> +static bool hdmi_find_code(const struct hdmi_config *timings_arr=
,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int len, struct hdmi_co=
nfig *timing)
>> >> =A0{
>> >> - =A0 =A0 int code;
>> >> + =A0 =A0 int i;
>> >>
>> >> - =A0 =A0 if (hdmi.mode =3D=3D 0)
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 code =3D code_vesa[hdmi.code];
>> >> - =A0 =A0 else
>> >> - =A0 =A0 =A0 =A0 =A0 =A0 code =3D code_cea[hdmi.code];
>> >> + =A0 =A0 for (i =3D 0; i < len; i++) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (timings_arr[i].cm.code =3D=3D hdmi.=
code) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *timing =3D timings_arr=
[i];
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 return false;
>> >> +}
>> >
>> > You could return the hdmi_config pointer instead of making a copy =
and
>> > returning a bool.
>> In this function i'm passing the timing value and finally there need=
s
>> to be one copy whether it is in this function or after the return,
>> because the timings array is a const and dssdev->paneltimings and
>> config timings are not, so do you see any benefit of doing that late=
r
>> or suggest any other method?
>
> Well, I think it's just good design, even if it wouldn't help in this
> particular case.
>
> hdmi_find_code is a small utility function, and functions like that
> should be designed to be usable in any situation. In this particular
> situation you will anyway make a copy, and it doesn't matter if it's =
the
> utility function that does the copy.
>
> But in some other case you could perhaps be interested in only one va=
lue
> in the hdmi_config that is found. In that case doing a copy is extra,
> and it'd be better to return the const struct pointer.
>
> Also, it is a standard design pattern that a "find" function returns
> pointer to the found item, whereas your version returning a bool and
> making a copy of the found item is not very standard.
>
Well i shall update the change to the standard way then :-).

Thanks and regards,
Mythri.
> =A0Tomi
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
