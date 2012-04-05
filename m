From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: OMAP3EVM not booting on l-o master
Date: Thu, 5 Apr 2012 15:53:25 +0530
Message-ID: <CAMrsUdJV_JVmqqyR7fpX+efOr9Z43oZX0FkJN5Q7-f2YkFFvJQ@mail.gmail.com>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com> <C8443D0743D26F4388EA172BF4E2A7A9317C47AD@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204050414570.10302@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:39942 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752983Ab2DEKXr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Apr 2012 06:23:47 -0400
Received: by obbuo13 with SMTP id uo13so1713305obb.20
        for <linux-omap@vger.kernel.org>; Thu, 05 Apr 2012 03:23:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204050414570.10302@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Mohammed Afzal <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, tony@atomide.com

Hi Afzal,

On Thu, Apr 5, 2012 at 3:47 PM, Paul Walmsley <paul@pwsan.com> wrote:
> cc Tony
>
> Hi,
>
> On Thu, 5 Apr 2012, Mohammed, Afzal wrote:
>
>> On Thu, Apr 05, 2012 at 15:03:36, Paul Walmsley wrote:
>> > Could you try booting with initcall_debug and posting the boot log=
?
>>
>> Logs as follows,
>
> thanks.
>
> ...
>
>> [ =A0 =A06.065307] calling =A0omap_mux_late_init+0x0/0x1a0 @ 1
>
> Looks like a mux-related problem. =A0Tony recently found some mux-rel=
ated
> bugs that got merged with the v3.3 mach-omap2/serial.c - I wonder if =
they
> might be affecting your board too?

Can you try this patch [1], Just to confirm its serial mux issue

however still the patch is not aligned on how to fix it.

--
Thanks,
Govindraj.R

[1]:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg65347.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
