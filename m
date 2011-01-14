From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: Passing mem=1G to kernel on Panda, system is unstable.
Date: Fri, 14 Jan 2011 18:09:45 +0800
Message-ID: <AANLkTimoSGkQV8suHD0-KFBq1wZc-VkzZ8ziZ81QaL9V@mail.gmail.com>
References: <AANLkTin+ZjUoD9i+JxV7wW2+U6oEp42PdP5R4gdtzy=F@mail.gmail.com>
 <alpine.DEB.2.00.1101121649560.5731@utopia.booyaka.com> <AANLkTi=X-yUNvSkn-qNrAGSUoy_sNy9FzkeCzFECsBZF@mail.gmail.com>
 <alpine.DEB.2.00.1101132240220.28621@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50978 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab1ANKKI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 05:10:08 -0500
Received: by qyk12 with SMTP id 12so3178465qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 02:10:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101132240220.28621@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Jan, Sebastien" <s-jan@ti.com>, linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

On Fri, Jan 14, 2011 at 1:41 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Thu, 13 Jan 2011, Bryan Wu wrote:
>
>> On Thu, Jan 13, 2011 at 7:50 AM, Paul Walmsley <paul@pwsan.com> wrot=
e:
>> > On Wed, 12 Jan 2011, Bryan Wu wrote:
>> >
>> > Does the problem also happen if you boot with 'nosmp' on the kerne=
l
>> > command line?
>>
>> Yeah, I think so, since Sebastien reported that 'nosmp' doesn't work=
 either.
>
> Will try to find time to give this a shot. =A0You might want to try a=
 build
> without CONFIG_SMP set to see if it helps.
>
Thanks a lot, man. Sebastien and I will try to disable CONFIG_SMP with
mainline kernel on Panda.

> Is the rootfs that you used downloadable from anywhere?
>
Please check this wiki page:
http://omappedia.org/wiki/Ubuntu_rootfs

I use following command to build a latest Natty (11.04) Ubuntu rootfs.
sudo rootstock -d natty -f ubuntu -l ubuntu -p ubuntu --serial ttyO2
--locale en_US.UTF-8 -s ubuntu-minimal,openssh-server,

Thanks,
--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
