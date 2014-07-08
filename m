From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH/RESEND 0/9] drm: tilcdc driver fixes
Date: Tue, 8 Jul 2014 11:32:12 +1000
Message-ID: <CAPM=9tyfpewNYbAGw12Mkvc_6UhVgWxb+=pqfHr0hdOD_VHg7g@mail.gmail.com>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
	<1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
	<53ADEB73.8090301@ti.com>
	<20140701233958.GA31549@fox>
	<53B36EF1.8060200@ti.com>
	<CAPM=9tzQR446Xc2xnrSOGa+VetO44KskMFrkPqbatwsmv1dHXQ@mail.gmail.com>
	<20140702203858.GA9576@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34861 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbaGHBcN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2014 21:32:13 -0400
Received: by mail-lb0-f181.google.com with SMTP id p9so3487550lbv.12
        for <linux-omap@vger.kernel.org>; Mon, 07 Jul 2014 18:32:12 -0700 (PDT)
In-Reply-To: <20140702203858.GA9576@arch.cereza>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?Q?Ezequiel_Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>
Cc: Darren Etheridge <detheridge@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org

On 3 July 2014 06:38, Ezequiel Garc=C3=ADa <ezequiel@vanguardiasur.com.=
ar> wrote:
> On 02 Jul 02:08 PM, Dave Airlie wrote:
>> On 2 July 2014 12:31, Darren Etheridge <detheridge@ti.com> wrote:
>> > On 07/01/2014 06:39 PM, Guido Mart=C3=ADnez wrote:
>> >>
>> >> On Fri, Jun 27, 2014 at 05:08:51PM -0500, Darren Etheridge wrote:
>> >>>
>> >>> [snip]
>> >>>
>> >>> Otherwise I think this is a good and useful patch series.
>> >>
>> >> It that a Tested-by tag? :)
>> >
>> >
>> > Sure - I would prefer that the WARN_ON was silenced when the tilcd=
c module
>> > is removed, but the series adds improvements over what is there no=
w.  I have
>> > tested it across a few variants of AM335x boards and attached disp=
lay
>> > hardware in both module form and built-in to the kernel, therefore=
:
>> >
>> > Tested-by: Darren Etheridge <detheridge@ti.com>
>>
>> Has someone gathered that tags and put these in a git tree by any ch=
ance?
>>
>
> I don't think anyone has. Is that a problem?
>
> If you need a pull request with these, I can prepare something in bit=
bucket.
> Would that work you?

I've picked them up manually now, so should be all fine.

Thanks,
Dave.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
