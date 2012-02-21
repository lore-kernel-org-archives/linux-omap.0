From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: Move Avi-infoframe struct to hdmi_ip_data
Date: Tue, 21 Feb 2012 16:38:34 +0530
Message-ID: <CAP5A+B8JNVe4_O4E34FFjuO-pggeuQPhPqvHQ74fCit8+UoB2w@mail.gmail.com>
References: <1329812560-7945-1-git-send-email-mythripk@ti.com> <1329813601.2090.1.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:46845 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754949Ab2BULIz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 06:08:55 -0500
Received: by mail-iy0-f170.google.com with SMTP id k32so10480404iak.29
        for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 03:08:54 -0800 (PST)
In-Reply-To: <1329813601.2090.1.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, Feb 21, 2012 at 2:10 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Tue, 2012-02-21 at 13:52 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> With AVI infoframe various parameters of video stream such as
>> aspect ratio, quantization range, videocode etc will be indicated
>> from source to sink.Thus AVI information needs to be set/accessed
>> by the middle ware based on the video content.
>> Thus this parameter is now moved to the ip_data structure.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>
> I have already applied this patch. Have you made some new changes to =
it?
>
No,
I just did a rebase.

Thanks and regards,
Mythri.
> =A0Tomi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
