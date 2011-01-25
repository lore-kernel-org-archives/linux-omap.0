From: Hari Kanigeri <hari.kanigeri@gmail.com>
Subject: Re: [PATCH 01/32] arm/omap: use system_wq in mailbox
Date: Tue, 25 Jan 2011 07:34:08 -0800
Message-ID: <AANLkTi=Z_ykZptzgi7kt3g21sebEV+hGN72iRcBDC1oC@mail.gmail.com>
References: <1294062595-30097-1-git-send-email-tj@kernel.org>
	<1294062595-30097-2-git-send-email-tj@kernel.org>
	<AANLkTimMK2Ec8SQiRyRBR+MdVKhAmMaaf+oa0VK3wWsf@mail.gmail.com>
	<20110104052421.GD6748@mtj.dyndns.org>
	<20110125134722.GZ27510@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41076 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab1AYPeJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 10:34:09 -0500
In-Reply-To: <20110125134722.GZ27510@htj.dyndns.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Tejun,

On Tue, Jan 25, 2011 at 5:47 AM, Tejun Heo <tj@kernel.org> wrote:
> On Tue, Jan 04, 2011 at 06:24:21AM +0100, Tejun Heo wrote:
>> Using dedicated workqueue or system_wq doesn't make any difference i=
n
>> terms of execution latency anymore. =A0Sleeping work items no longer
>> delay execution of other work items. =A0If mailbox is very latency
>> sensitive, it might make sense to create a HIGHPRI workqueue but tha=
t
>> usually isn't necessary.
>
> Ping. =A0Shall I apply the patch?
>
I am sorry for the delay in acking your response.  Your patch looks goo=
d to me.

thank you,
best regards,
Hari
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
