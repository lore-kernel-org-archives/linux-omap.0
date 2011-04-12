From: Bob Liu <lliubbo@gmail.com>
Subject: Re: pandaboard can't reboot on 2.6.38-rc2?
Date: Tue, 12 Apr 2011 13:38:04 +0800
Message-ID: <BANLkTikmMzD7coDnBgM9KCwjP8dV3rzgMQ@mail.gmail.com>
References: <BANLkTikjyaA4mL-eWOcPse2T7NC2rbCfkg@mail.gmail.com>
	<cac49110c8a25779b39fbf0f5808bdc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52045 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab1DLFiF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Apr 2011 01:38:05 -0400
Received: by qwk3 with SMTP id 3so3659928qwk.19
        for <linux-omap@vger.kernel.org>; Mon, 11 Apr 2011 22:38:04 -0700 (PDT)
In-Reply-To: <cac49110c8a25779b39fbf0f5808bdc7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, Apr 12, 2011 at 12:58 PM, Anand Gadiyar <gadiyar@ti.com> wrote:
> Bob Liu wrote:
>> Hi, folks
>>
>> I am using pandaboard and compiled a 2.6.38-rc2 kernel for it.
>> Everything works fine except that it can't reboot.
>>
>> #reboot
>> #
>> The system is going down NOW!
>> Sent SIGTERM to all processes
>> Sent SIGKILL to all processes
>> Requesting system reboot
>> [ =C2=A0120.742370] Restarting system.
>>
>> Then hanged...
>>
>> Has anyone seen similar problem?
>
> As a quick workaround, turn off CONFIG_ARCH_OMAP2 and
> rebuild the kernel. That should get you functional reboots.
>

It works, Thanks!

> Looks like something in the asm code is messed up when building
> with OMAP2 support - I don't understand it well enough to solve
> it, but maybe this is a data point for people that do know
> the code better.
>
> - Anand
>

--=20
Regards,
--Bob
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
