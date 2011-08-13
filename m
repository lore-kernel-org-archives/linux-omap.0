From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: tidspbridge issue with omap_dm_timer_free
Date: Sat, 13 Aug 2011 12:12:15 -0500
Message-ID: <CAB-zwWhzf_cjN+1dCFzTRMW6Y1UhyTHm+mTk1EkYrrdKPsgu5g@mail.gmail.com>
References: <CAMP44s17O-g83Fte05=AmqBP24jqgLxiBHmO6+3fbtJjWV8Ufw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:36184 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751751Ab1HMRR0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 13 Aug 2011 13:17:26 -0400
Received: by vxh13 with SMTP id 13so5310882vxh.16
        for <linux-omap@vger.kernel.org>; Sat, 13 Aug 2011 10:17:25 -0700 (PDT)
In-Reply-To: <CAMP44s17O-g83Fte05=AmqBP24jqgLxiBHmO6+3fbtJjWV8Ufw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>

On Wed, Aug 10, 2011 at 1:42 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Hi,
>
> I am trying to use a more recent version of the tidspbridge code in
> the Nokia N9, but I'm stuck with this warning that is caused by using
> the dm timer framework.
>
> [ =A0 30.883636] BUG: sleeping function called from invalid context a=
t
> kernel/mutex.c:287
> [ =A0 30.885925] in_atomic(): 1, irqs_disabled(): 0, pid: 305, name: =
mboxd/0
> [ =A0 30.892517] 3 locks held by mboxd/0/305:
> [ =A0 30.896392] =A0#0: =A0(mboxd){+.+...}, at: [<b0081778>] worker_t=
hread+0x154/0x2bc
> [ =A0 30.903533] =A0#1: =A0(&mq->work){+.+...}, at: [<b0081778>]
> worker_thread+0x154/0x2bc
> [ =A0 30.911041] =A0#2: =A0(pwr_lock){+.....}, at: [<af12f870>]
> handle_hibernation_from_dsp+0x1c/0x158 [bridgedriver]
> [ =A0 30.920959] [<b003f75c>] (unwind_backtrace+0x0/0xd4) from
> [<b03a3ac4>] (mutex_lock_nested+0x30/0x32c)
> [ =A0 30.930175] [<b03a3ac4>] (mutex_lock_nested+0x30/0x32c) from
> [<b00568f8>] (clk_set_parent+0x34/0xf8)
=2E..
> From what I can see this could be triggered in upstream by enabling P=
M
> and debug mutex stuff right after loading the baseimage.
>
> Any ideas?

May I know which kernel version are you using? I can't seem to find
the mutex_lock inside clk_set_parent in arch/arm/plat-omap/clock.c.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
