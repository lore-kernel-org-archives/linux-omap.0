From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP: dmtimer: Use devm_ API and do some cleanup
 in probe()
Date: Tue, 17 Apr 2012 10:31:17 +0530
Message-ID: <CAC83ZvKLwU-vz0WHeZK5B7ELw1ddqK+=xn8K0e9kn1MmqdpqSw@mail.gmail.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com>
	<1334579125-15566-2-git-send-email-tarun.kanti@ti.com>
	<4F8C346F.9020200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:34748 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751222Ab2DQFBT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Apr 2012 01:01:19 -0400
Received: by qcmt36 with SMTP id t36so6459197qcm.1
        for <linux-omap@vger.kernel.org>; Mon, 16 Apr 2012 22:01:18 -0700 (PDT)
In-Reply-To: <4F8C346F.9020200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, santosh.shilimkar@ti.com, rnayak@ti.com

On Mon, Apr 16, 2012 at 8:32 PM, Shubhrajyoti <shubhrajyoti@ti.com> wro=
te:
> On Monday 16 April 2012 05:55 PM, Tarun Kanti DebBarma wrote:
>> Replace the regular kzalloc and ioremap with the devm_ equivalent
>> to simplify error handling. We don't need kree() anymore in
>> omap_dm_timer_remove().
>>
>> Also added *dev* pointer to reference pdev->dev which makes the
>> usage shorter in code.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> ---
>>
> <snip>
>> - =A0 =A0 timer->io_base =3D ioremap(mem->start, resource_size(mem))=
;
>> + =A0 =A0 timer->io_base =3D devm_ioremap(dev, mem->start, resource_=
size(mem));
>> =A0 =A0 =A0 if (!timer->io_base) {
> Could we use =A0devm_request_and_ioremap here?
>
Yes, I will change. Thanks.
--
Tarun
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
