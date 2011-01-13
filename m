From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: Passing mem=1G to kernel on Panda, system is unstable.
Date: Thu, 13 Jan 2011 08:02:36 +0800
Message-ID: <AANLkTi=X-yUNvSkn-qNrAGSUoy_sNy9FzkeCzFECsBZF@mail.gmail.com>
References: <AANLkTin+ZjUoD9i+JxV7wW2+U6oEp42PdP5R4gdtzy=F@mail.gmail.com> <alpine.DEB.2.00.1101121649560.5731@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53866 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756424Ab1AMAC7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jan 2011 19:02:59 -0500
Received: by qwa26 with SMTP id 26so1220718qwa.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Jan 2011 16:02:58 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101121649560.5731@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Jan, Sebastien" <s-jan@ti.com>
Cc: linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

On Thu, Jan 13, 2011 at 7:50 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 12 Jan 2011, Bryan Wu wrote:
>
>> We are trying to build kernel package or GCC natively on OMAP4 panda
>> board. With the mainline 2.6.37 kernel or Ubuntu Natty 2.6.35 based
>> kernel, we met same instabilities on the system when we try to use
>> mem=1G on the board.
>>
>> Please find our bug tracker here:
>> https://bugs.launchpad.net/ubuntu/+source/linux-ti-omap4/+bug/633227
>> and I think another bug is also related:
>> https://bugs.launchpad.net/ubuntu/+source/linux-ti-omap4/+bug/690370.
>> System will freeze at all when building GCC natively on Panda.
>>
>> Did any folks meet this issue? or we need more simple test case to
>> catch the root cause of this issue.
>
> Does the problem also happen if you boot with 'nosmp' on the kernel
> command line?
>

Yeah, I think so, since Sebastien reported that 'nosmp' doesn't work either.

Thanks,
-Bryan
