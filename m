From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] OMAP4: panda: Correct cpu version check for 4430
Date: Tue, 28 Feb 2012 09:33:51 +0200
Message-ID: <4F4C835F.9020900@ti.com>
References: <1329470861-29795-1-git-send-email-peter.ujfalusi@ti.com> <20120222230446.GU18185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:52811 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755026Ab2B1Hd6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 02:33:58 -0500
Received: by lahl5 with SMTP id l5so2713124lah.15
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 23:33:55 -0800 (PST)
In-Reply-To: <20120222230446.GU18185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Girdwood <lrg@ti.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On 02/23/2012 01:04 AM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [120217 00:56]:
>> The cpu_is_omap4430() macro always return with 0. Use the correct
>> cpu_is_omap443x() to check for Panda revision.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>
>> Hi,
>>
>> Since the depending patches are going via Liam's tree it would be be=
st if we
>> can queue this via audio as well.
>> Without this patch the audio on Panda 4430 is not working correctly.
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>

Liam can you pick this patch since it is needed for Panda to correctly
identify the 4430/4460 version of the board.

Thanks,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
