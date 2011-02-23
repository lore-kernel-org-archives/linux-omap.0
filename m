From: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Subject: Re: [PATCH v3 00/13] OMAP: McBSP: hwmod adaptation and runtime conversion
Date: Wed, 23 Feb 2011 15:43:24 +0530
Message-ID: <AANLkTinfymZZRDwXHsvOhBU7KTVBRakdZAp46M3JfGD6@mail.gmail.com>
References: <1298038948-19871-1-git-send-email-kishon@ti.com>
	<4D636651.30904@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:37136 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751515Ab1BWKN0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 05:13:26 -0500
Received: by gxk7 with SMTP id 7so1506186gxk.30
        for <linux-omap@vger.kernel.org>; Wed, 23 Feb 2011 02:13:25 -0800 (PST)
In-Reply-To: <4D636651.30904@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, broonie@opensource.wolfsonmicro.com, jhnikula@gmail.com, p-basak2@ti.com, charu@ti.com, shubhrajyoti@ti.com

On Tue, Feb 22, 2011 at 1:01 PM, Peter Ujfalusi
<peter.ujfalusi@nokia.com> wrote:
> On 02/18/11 16:22, ext Kishon Vijay Abraham I wrote:
>> Modify OMAP McBSP driver to use omap hwmod framework and pm runtime =
=A0APIs.
>>
>> Created on top of linux OMAP master (linux-omap-2.6 :master)
>>
>> Did digital loopback testing on OMAP4430, OMAP3430, OMAP2430 and OMA=
P
>> 1710 SDP boards.
>> Tested audio on 3430 SDP board (by me) and N810 (by Jarkko Nikula).
>> Tested PM with audio and verified the patch series does not cause re=
gression.
>> PM testing comprises of suspend/resume between consecutive audio pla=
yback.
>> Support for suspend/resume in the middle of audio playback will be d=
one by
>> audio guys on top of this patch series.
>>
>> Patch series requires the following patch to be present
>> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51132
>> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51133
>> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51134
>
> I don't see further issues with this series.
> Since my ack is already in place on the patches, the only thing I can
> say is:
> Good work, thank you!

  Hi Tony,

  Will you be merging this patch series?

  -Kishon

>
> --
> P=E9ter
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
