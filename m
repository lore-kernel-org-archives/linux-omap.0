From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] cpufreq: OMAP updates for v3.4
Date: Wed, 14 Mar 2012 10:22:38 -0700
Message-ID: <87wr6ngkrl.fsf@ti.com>
References: <87y5rci2na.fsf@ti.com>
	<CANOLnON91vXWb2L-FXjz3sqq-9j5SaEodtpt_yvFiN33D4Q3Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:59173 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755051Ab2CNRW2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Mar 2012 13:22:28 -0400
Received: by mail-ee0-f41.google.com with SMTP id e53so1268057eek.0
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 10:22:27 -0700 (PDT)
In-Reply-To: <CANOLnON91vXWb2L-FXjz3sqq-9j5SaEodtpt_yvFiN33D4Q3Ow@mail.gmail.com>
	(Grazvydas Ignotas's message of "Wed, 14 Mar 2012 18:41:51 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Dave Jones <davej@redhat.com>, cpufreq@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Grazvydas Ignotas <notasas@gmail.com> writes:

[...]

>> Russell King (1):
>> =C2=A0 =C2=A0 =C2=A0cpufreq: OMAP driver depends CPUfreq tables
>
> It seems this one got messed up, it says "default ARCH_OMAP2PLUS"
> instead of depends.

That was intentional.  What do you think is messed up about it?

It's the same as saying:

     depends on ARCH_OMAP2PLUS
     default y

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
