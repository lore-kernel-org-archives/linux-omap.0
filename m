From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH 5/5] OMAP4: DSS2: VIDEO3 pipeline support
Date: Fri, 5 Aug 2011 09:43:02 +0100
Message-ID: <CAB2ybb_5saT0_DCcL5iTKaNfJfV32iQvV_mhv_uC+tt-J4CNgA@mail.gmail.com>
References: <1312530172-24095-1-git-send-email-archit@ti.com>
 <1312530172-24095-6-git-send-email-archit@ti.com> <CAB2ybb_fDM8bDr1CsFUHRhE9fNoSKvOoWTktQGzh+VV=efEMZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:33042 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751094Ab1HEInX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Aug 2011 04:43:23 -0400
Received: by mail-fx0-f42.google.com with SMTP id 23so318041fxe.29
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 01:43:22 -0700 (PDT)
In-Reply-To: <CAB2ybb_fDM8bDr1CsFUHRhE9fNoSKvOoWTktQGzh+VV=efEMZw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org

> On Fri, Aug 5, 2011 at 8:42 AM, Archit Taneja <archit@ti.com> wrote:
>>
>> Add support for VIDEO3 pipeline on OMAP4:
>> - Add VIDEO3 pipeline information in dss_features and omapdss.h
>> - Add VIDEO3 pipeline register coefficients in dispc.h
>> - Create a new overlay structure corresponding to VIDEO3.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
<snip>
>> - =A0 =A0 =A0 u32 =A0 =A0 fifo_size[3];
>> + =A0 =A0 =A0 u32 =A0 =A0 fifo_size[MAX_DSS_OVERLAYS];
>
Do you think it makes some sense in splitting the 'generalisation'
like this that you've done in the patch from the xxx_VIDEO3 changes?
It might make it look a little cleaner; otherwise the changes look
good to me; feel free to add my reviewed-by. [and to other patches in
this series].
>>
<snip>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
