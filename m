From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v3 00/10]HDMI: Split hdmi.c in DSS to seperate OMAP dependent
Date: Tue, 6 Sep 2011 15:09:43 +0530
Message-ID: <CAP5A+B9RNhagZfD8-HqoE7rOWrFTYUChzu72iTXwD1yfddaOjw@mail.gmail.com>
References: <1314960470-2616-1-git-send-email-mythripk@ti.com>
 <1315224916.1825.2.camel@lappyti> <CAP5A+B-Fcx=mqYf_uCGPPw1Wn_D=6eZ0dZxX7vK2OXC2-vaQpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:43342 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753299Ab1IFJkE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Sep 2011 05:40:04 -0400
Received: by vxi9 with SMTP id 9so5767600vxi.5
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 02:40:03 -0700 (PDT)
In-Reply-To: <CAP5A+B-Fcx=mqYf_uCGPPw1Wn_D=6eZ0dZxX7vK2OXC2-vaQpA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, "Neri, Ricardo" <ricardo.neri@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Mon, Sep 5, 2011 at 6:52 PM, K, Mythri P <mythripk@ti.com> wrote:
> Hi,
>
> On Mon, Sep 5, 2011 at 5:45 PM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
>> On Fri, 2011-09-02 at 16:17 +0530, mythripk@ti.com wrote:
>>> From: Mythri P K <mythripk@ti.com>
>>>
>>> HDMI IP block is common between TI OMAP4 Procerssor and Netra proce=
ssor although
>>> the Display subsytem is different.Also the IP block in future OMAP =
may differ
>>> from the one existing in OMAP4. Thus to reuse the code between thes=
e two
>>> processors , and maintain the multi omap build functionality in DSS=
=2E
>>> HDMI IP dependant code is seperated out from hdmi.c and moved to
>>> new library file hdmi_ti_4xxx_ip.c.From the DSS dependent HDMI code=
 only the
>>> function pointer to functionality/features offered by HDMI is calle=
d.
>>>
>>> This patch series does the split and also renames hdmi_omap4_panel.=
c to
>>> hdmi_panel.c as that file has nothing specific to OMAP4 and can be =
reused for
>>> other OMAP family of processors as well.
>>>
>>> This patch series is based on Tomi's LO-DSS2 master branch.
>>
>> The kernel doesn't compile at all after enabling
>> SND_OMAP_SOC_OMAP4_HDMI. Looks like you didn't move any of the sound
>> stuff, but just left them in hdmi.c file.
>>
> I shall check this, may be i should handle some dependency but i didn=
t
> think there were any direct dependency , i guess you need to enable
> some audio files as well? let me check.

There is a dependency on the audio files on the register writers and i
was not very sure on what would be a genuine API v's what can be a
static function.
Ricardo any comments would you like to post a patch on top of this seri=
es ?

thanks and regards,
Mythri.
>> =A0Tomi
>>
>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
