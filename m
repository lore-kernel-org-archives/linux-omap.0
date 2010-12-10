From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCHv2 0/4] staging: tidspbridge - misc fixes
Date: Fri, 10 Dec 2010 10:16:14 -0600
Message-ID: <AANLkTi=2Med5qeYNHRkFAAU1syK1Y1-cAfqWz9uAZsFU@mail.gmail.com>
References: <1291953342-4905-1-git-send-email-fernando.lugo@ti.com>
	<4D021047.9080300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D021047.9080300@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: omar.ramirez@ti.com, linux-kernel@vger.kernel.org, felipe.contreras@gmail.com, ohad@wizery.com, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 10, 2010 at 5:34 AM, Nishanth Menon <nm@ti.com> wrote:
> Fernando Guzman Lugo wrote, on 12/09/2010 09:55 PM:
>>
>> * V2
>> =A0- rebase to the latest
>> =A0- remove patches no needed at this moment
>>
>> This set of patches fix some issues found in lastest tree.
>>
>> Fernando Guzman Lugo (4):
>> =A0 staging: tidspbridge - use GTP7 for DSP stack dump
>> =A0 staging: tidspbridge - fix timeout in dsp_gpt_wait_overflow
>> =A0 staging: tidspbridge - remove disabling twl when printing DSP st=
ack
>> =A0 staging: tidspbridge - change mmufault tasklet to a workqueue
>>
>> =A0drivers/staging/tidspbridge/core/_deh.h =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 +-
>> =A0drivers/staging/tidspbridge/core/dsp-clock.c =A0 =A0 =A0 | =A0 17=
 ++++---
>> =A0drivers/staging/tidspbridge/core/ue_deh.c =A0 =A0 =A0 =A0 =A0| =A0=
 55
>> +++++++++++--------
>> =A0.../staging/tidspbridge/include/dspbridge/clk.h =A0 =A0| =A0 =A04=
 +-
>> =A04 files changed, 46 insertions(+), 32 deletions(-)
>>
> Suggest looping in Linux-omap as well.

Yes, it was weird linux-omap was not showed by get_maintainer.pl script=
 :(.

Regards,
=46ernando.

>
> --
> Regards,
> Nishanth Menon
>
