From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Sat, 27 Aug 2011 23:33:26 +0800
Message-ID: <CACVXFVM_p_XPyOOgz7kbEo93SCCxPa4X_vjYGm+fUGMPSFM4EA@mail.gmail.com>
References: <1314456515-16419-1-git-send-email-ming.lei@canonical.com>
	<20110827151317.GA10013@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49205 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab1H0Pd1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Aug 2011 11:33:27 -0400
In-Reply-To: <20110827151317.GA10013@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: stern@rowland.harvard.edu, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

On Sat, Aug 27, 2011 at 11:13 PM, Greg KH <greg@kroah.com> wrote:
> On Sat, Aug 27, 2011 at 10:48:35PM +0800, ming.lei@canonical.com wrot=
e:
>> From: Ming Lei <ming.lei@canonical.com>
>>
>> This patch fixs one performance bug on ARM Cortex A9 dual core platf=
orm,
>> which has been reported on quite a few ARM machines(OMAP4, Tegra 2, =
snowball...),
>> see details from link of https://bugs.launchpad.net/bugs/709245.
>>
>> In fact, one mb() on ARM is enough to flush L2 cache, but
>> 'dummy->hw_token =3D token;' after mb() is added just for obeying
>> correct mb() usage.
>
> Really? =A0A mb() should not be flushing any caches, it's just a memo=
ry
> barrier. =A0Or is ARM somehow "special" in this way?

As Santosh pointed out, mb on ARM will flush L2 write buffer. The
description here is wrong.

I think the below should make the writing reach into memory on all
ARCH after ' token =3D dummy->hw_token;' is executed.

                       dummy->hw_token =3D token;
                       mb()
                       token =3D dummy->hw_token;

The above is the idea introduced to fix the problem.

>
>> The patch has been tested ok on OMAP4 panda A1 board, the performanc=
e
>> of 'dd' over usb mass storage can be increased from 4~5MB/sec to
>> 14~16MB/sec after applying this patch.
>
> That's impressive, but I don't think this is really the proper way to=
 do
> this...
>
>> Signed-off-by: Ming Lei <ming.lei@canonical.com>
>> ---
>> =A0drivers/usb/host/ehci-q.c | =A0 14 ++++++++++++++
>> =A01 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
>> index 0917e3a..65b5021 100644
>> --- a/drivers/usb/host/ehci-q.c
>> +++ b/drivers/usb/host/ehci-q.c
>> @@ -1082,6 +1082,20 @@ static struct ehci_qh *qh_append_tds (
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wmb ();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dummy->hw_token =3D toke=
n;
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The mb() below is added=
 to make sure that
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 'token' can be writen=
 into qtd, so that ehci
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* HC can see the up-to-=
date qtd descriptor. On
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* some archs(at least o=
n ARM Cortex A9 dual core),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* writing into coherene=
t memory doesn't mean the
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* value written can rea=
ch physical memory
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* immediately, and the =
value may be buffered
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* inside L2 cache. 'dum=
my->hw_token =3D token;'
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* after mb() is added f=
or obeying correct mb()
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* usage.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mb();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 token =3D dummy->hw_token;
>
> Your comment does not match the code, so something is wrong here.

If you mean "L2 cache flush", I confess to the mistaken description,
and will update it later. If you mean others, could you help to point i=
t out?

thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
