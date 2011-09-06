From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v3 00/10]HDMI: Split hdmi.c in DSS to seperate OMAP dependent
Date: Tue, 6 Sep 2011 16:58:10 +0530
Message-ID: <CAP5A+B-WeYQ+FJqSTqSEsdMaBmHOViT7-6rgyR1DSZBvmE9Oyg@mail.gmail.com>
References: <1314960470-2616-1-git-send-email-mythripk@ti.com>
 <1315224916.1825.2.camel@lappyti> <CAP5A+B-Fcx=mqYf_uCGPPw1Wn_D=6eZ0dZxX7vK2OXC2-vaQpA@mail.gmail.com>
 <CAP5A+B9RNhagZfD8-HqoE7rOWrFTYUChzu72iTXwD1yfddaOjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:36964 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753411Ab1IFL2b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Sep 2011 07:28:31 -0400
Received: by mail-vx0-f171.google.com with SMTP id 2so2354967vxh.2
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 04:28:30 -0700 (PDT)
In-Reply-To: <CAP5A+B9RNhagZfD8-HqoE7rOWrFTYUChzu72iTXwD1yfddaOjw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, "Neri, Ricardo" <ricardo.neri@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Tue, Sep 6, 2011 at 3:09 PM, K, Mythri P <mythripk@ti.com> wrote:
> Hi,
>
> On Mon, Sep 5, 2011 at 6:52 PM, K, Mythri P <mythripk@ti.com> wrote:
>> Hi,
>>
>> On Mon, Sep 5, 2011 at 5:45 PM, Tomi Valkeinen <tomi.valkeinen@ti.co=
m> wrote:
>>> On Fri, 2011-09-02 at 16:17 +0530, mythripk@ti.com wrote:
>>>> From: Mythri P K <mythripk@ti.com>
>>>>
>>>> HDMI IP block is common between TI OMAP4 Procerssor and Netra proc=
essor although
>>>> the Display subsytem is different.Also the IP block in future OMAP=
 may differ
>>>> from the one existing in OMAP4. Thus to reuse the code between the=
se two
>>>> processors , and maintain the multi omap build functionality in DS=
S.
>>>> HDMI IP dependant code is seperated out from hdmi.c and moved to
>>>> new library file hdmi_ti_4xxx_ip.c.From the DSS dependent HDMI cod=
e only the
>>>> function pointer to functionality/features offered by HDMI is call=
ed.
>>>>
>>>> This patch series does the split and also renames hdmi_omap4_panel=
=2Ec to
>>>> hdmi_panel.c as that file has nothing specific to OMAP4 and can be=
 reused for
>>>> other OMAP family of processors as well.
>>>>
>>>> This patch series is based on Tomi's LO-DSS2 master branch.
>>>
>>> The kernel doesn't compile at all after enabling
>>> SND_OMAP_SOC_OMAP4_HDMI. Looks like you didn't move any of the soun=
d
>>> stuff, but just left them in hdmi.c file.
>>>
>> I shall check this, may be i should handle some dependency but i did=
nt
>> think there were any direct dependency , i guess you need to enable
>> some audio files as well? let me check.
>
> There is a dependency on the audio files on the register writers and =
i
> was not very sure on what would be a genuine API v's what can be a
> static function.
> Ricardo any comments would you like to post a patch on top of this se=
ries ?
>
I have made a temporary patch to move the IP  dependent audio
functions to ti_hdmi_4xxx_ip.c and i see it compiles fine, later on we
can decide on what could be the API's and move the audio(non IP
dependent ) portion out of  DSS ?
are you ok with that ?

Thanks and regards,
Mythri.
> thanks and regards,
> Mythri.
>>> =A0Tomi
>>>
>>>
>>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
