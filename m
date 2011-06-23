From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 1/8] OMAP4: DSS: HDMI: HDMI clean up to pass base_address
Date: Thu, 23 Jun 2011 16:39:07 +0530
Message-ID: <BANLkTi=ukgHgGGd1d6C8+EF4cOt0OgS5eA@mail.gmail.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308298637-29753-2-git-send-email-mythripk@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D625B05@dbde02.ent.ti.com>
 <BANLkTin6ZShO-fmcA-FOm5f+XdhnR3iLDA@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593024D6C27CB@dbde02.ent.ti.com>
 <BANLkTinia6hMs7UjjoT=qjqgZVM9XL3ggQ@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593024D6C2816@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:54990 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758206Ab1FWLJ3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 07:09:29 -0400
Received: by fxm11 with SMTP id 11so1796273fxm.13
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 04:09:27 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2816@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

Hi Sanjeev,

On Thu, Jun 23, 2011 at 4:33 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: K, Mythri P
>> Sent: Thursday, June 23, 2011 4:30 PM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org; Valkeinen, Tomi
>> Subject: Re: [PATCH 1/8] OMAP4: DSS: HDMI: HDMI clean up to
>> pass base_address
>>
>> Hi Sanjeev,
>>
>> <snip>
>> >> >
>> >> > =A0 =A0 The changes in the patch aren't limited to DSS alone.
>> >> > =A0 =A0 See updated to hdmi_core_audio_config(),
>> >> hdmi_wp_audio_config_format(),
>> >> > =A0 =A0 hdmi_wp_audio_config_dma(), etc.
>> >> >
>> >> The changes are related to the HDMI driver which as of
>> this patch is
>> >> in DSS. You see any concerns ? It is only later that those
>> functions
>> >> are moved out .
>> >
>> > [sp] The subject of mail indicates that changes are meant for DSS.
>> > =A0 =A0 How are the functions I quoted related to DSS? Unless
>> DSS on OMAP4
>> > =A0 =A0 supports audio...
>> >
>> Some of the Audio configuration for HDMI is part of DSS (as of 2.6.4=
0)
>> , This patch series is precisely to separate the DSS portion from
>> non-DSS portion of HDMI.
>> It would be great if you have a look at the 2.6.40 kernel and this
>> gitorious tree with my patch set to get a fair idea.
>>
>
> [sp] Then I suggest dropping "DSS" from the subject.
>
The DSS is to indicate that the file that is changed in the current
patch  is a part of DSS directory.

> ~sanjeev



--=20
Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
