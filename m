From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v3 00/10]HDMI: Split hdmi.c in DSS to seperate OMAP dependent
Date: Mon, 5 Sep 2011 18:52:40 +0530
Message-ID: <CAP5A+B-Fcx=mqYf_uCGPPw1Wn_D=6eZ0dZxX7vK2OXC2-vaQpA@mail.gmail.com>
References: <1314960470-2616-1-git-send-email-mythripk@ti.com> <1315224916.1825.2.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:51132 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753017Ab1IENXC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Sep 2011 09:23:02 -0400
Received: by vws18 with SMTP id 18so5063657vws.13
        for <linux-omap@vger.kernel.org>; Mon, 05 Sep 2011 06:23:00 -0700 (PDT)
In-Reply-To: <1315224916.1825.2.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Mon, Sep 5, 2011 at 5:45 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> On Fri, 2011-09-02 at 16:17 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> HDMI IP block is common between TI OMAP4 Procerssor and Netra proces=
sor although
>> the Display subsytem is different.Also the IP block in future OMAP m=
ay differ
>> from the one existing in OMAP4. Thus to reuse the code between these=
 two
>> processors , and maintain the multi omap build functionality in DSS.
>> HDMI IP dependant code is seperated out from hdmi.c and moved to
>> new library file hdmi_ti_4xxx_ip.c.From the DSS dependent HDMI code =
only the
>> function pointer to functionality/features offered by HDMI is called=
=2E
>>
>> This patch series does the split and also renames hdmi_omap4_panel.c=
 to
>> hdmi_panel.c as that file has nothing specific to OMAP4 and can be r=
eused for
>> other OMAP family of processors as well.
>>
>> This patch series is based on Tomi's LO-DSS2 master branch.
>
> The kernel doesn't compile at all after enabling
> SND_OMAP_SOC_OMAP4_HDMI. Looks like you didn't move any of the sound
> stuff, but just left them in hdmi.c file.
>
I shall check this, may be i should handle some dependency but i didnt
think there were any direct dependency , i guess you need to enable
some audio files as well? let me check.
> =A0Tomi
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
