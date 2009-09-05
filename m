From: vimal singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH-v3 1:2] [MTD][NAND]omap: Adding support for nand
	prefetch-read and post-write, in MPU mode.
Date: Sat, 5 Sep 2009 15:36:21 +0530
Message-ID: <ce9ab5790909050306m180e7c22g7bbdea7f7053d159@mail.gmail.com>
References: <61339.192.168.10.89.1247226725.squirrel@dbdmail.itg.ti.com>
	<48097.192.168.10.89.1247232736.squirrel@dbdmail.itg.ti.com>
	<60361.192.168.10.89.1247482584.squirrel@dbdmail.itg.ti.com>
	<20090810162734.GH1938@atomide.com> <ce9ab5790908102245r28224bf5nfa2a1b22267767fe@mail.gmail.com>
	<4A810DE4.7030202@gmail.com> <ce9ab5790908102329k73f66b5bgcdd8ac52d6631116@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f182.google.com ([209.85.210.182]:56119 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbZIEKGk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Sep 2009 06:06:40 -0400
In-Reply-To: <ce9ab5790908102329k73f66b5bgcdd8ac52d6631116@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, dedekind@infradead.org, linux-kernel@vger.kernel.org, david-b@pacbell.net, linux-mtd@lists.infradead.org, vimal singh <vimalsingh@ti.com>, dwmw2@infradead.org

Hi David,


On Tue, Aug 11, 2009 at 11:59 AM, vimal singh<vimal.newwork@gmail.com> =
wrote:
> On Tue, Aug 11, 2009 at 11:51 AM, Artem Bityutskiy<dedekind1@gmail.co=
m> wrote:
>> On 08/11/2009 08:45 AM, vimal singh wrote:
>>>
>>> On Mon, Aug 10, 2009 at 9:57 PM, Tony Lindgren<tony@atomide.com> =C2=
=A0wrote:
>>>>
>>>> * vimal singh<vimalsingh@ti.com> =C2=A0[090713 13:56]:
>>>>>
>>>>> Patch updated for ' ioreadX / iowriteX and ioreadX_rep / iowriteX=
_rep'
>>>>> as per
>>>>> David Brownell's comment. I updated 'omap_(read/write)_buf16' fuc=
ntions
>>>>> also
>>>>> for this.
>>>>>
>>>>> -vimal
>>>>>
>>>>> This patch adds prefetch support to access nand flash in mpu mode=
=2E
>>>>> This patch also adds 8-bit nand support (omap_read/write_buf8).
>>>>> Prefetch can be used for both 8- and 16-bit devices.
>>>>>
>>>>> Signed-off-by: Vimal Singh<vimalsingh@ti.com>
>>>>
>>>> Sorry for the delay. I've looked at the GPMC part, and that now lo=
oks OK
>>>> to me. So I'm OK for this to get integrated via the MTD list.
>>>>
>>>> Acked-by: Tony Lindgren<tony@atomide.com>
>>>>
>>>
>>> Can you give your ack to below patch too?
>>>
>>> http://lists.infradead.org/pipermail/linux-mtd/2009-July/026373.htm=
l
>>
>> I've picked up both of your patches, please, check:
>> http://git.infradead.org/users/dedekind/l2-mtd-2.6.git/commit/33f48f=
597315842f39427ee4261cbf82a9afeaf3
>> http://git.infradead.org/users/dedekind/l2-mtd-2.6.git/commit/b67d52=
c91b26e97f981f2c292619d31667d5b272
>>
>
Is there any chance for these patches to get merged in this merge
window? These have been waiting for long time.

-Vimal

> Thanks Artem.
>
>> --
>> Best Regards,
>> Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=
=8E=D1=86=D0=BA=D0=B8=D0=B9)
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
