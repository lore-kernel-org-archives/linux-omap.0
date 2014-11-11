From: John Syn <john3909@gmail.com>
Subject: Re: SGX support on AM572x
Date: Tue, 11 Nov 2014 13:58:20 -0800
Message-ID: <D087AB25.5A4A5%john3909@gmail.com>
References: <D087A0BB.5A41E%john3909@gmail.com>
 <20141111195403.GA16958@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:46332 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbaKKV6Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2014 16:58:25 -0500
Received: by mail-pd0-f181.google.com with SMTP id y10so10749552pdj.26
        for <linux-omap@vger.kernel.org>; Tue, 11 Nov 2014 13:58:24 -0800 (PST)
In-Reply-To: <20141111195403.GA16958@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>


On 11/11/14, 11:54 AM, "Nishanth Menon" <nm@ti.com> wrote:

>On 11:17-20141111, John Syn wrote:
>> With the release of the Beagleboard-X15 in February 2015, I=A9=F6m t=
rying to
>> get a handle on the status of SGX support for the AM572x processor. =
Is
>> anyone working on adding this support and is there any schedule for
>> releasing SGX on AM572x? There is a lot of interest on the beagleboa=
rd
>> mailing list, but SGX support seems to be a big stumbling block.
>
>1. Are you looking for SGX driver support in
>https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/ ?
>
>OR
>
>2. Are you looking for distro support?
>
>OR
>3. Are you looking for what TI release(if any) will contain?
>
>for (1) you already have response from beagleboard mailing list - TI, =
to
>my knowledge will not support IMG[1] drivers in kernel.org - at least =
no
>known activity in the past present or future to do that.
Yeah, I think this is clearly understood.
>
>For (2): as the distro folks how they want to do things - again depend=
s
>on where you are getting your distro from.
The official distro for Beagleboard-X15 is Robert Nelson=A1=AFs Debian =
distro,
but as long as SGX is available for AM572x, I=A1=AFm sure Robert will f=
ind a
way to get this working.
>
>For (3): use TI support channel over e2e Phorums[2] and look at releva=
nt
>TI release's release notes. Things like [3] are handled properly that
>way.
I took a look in e2e and I did find one promising posting:

http://e2e.ti.com/support/omap/f/885/t/366372.aspx

However, this article and your reference [3] are for V3.8 and I believe
BeagleBoard-X15 will be released with V3.14 or V3.18. So my question is
related to [3] and SGX support for either V3.14 or V3.18.

Regards,
John
>
>
>Other recent references:
>https://plus.google.com/100242854243155306943/posts/TKX7GfHkTow
>http://beagleboard.org/Community/Forums?place=3Dmsg%2Fbeagleboard%2F1t=
3yxkPY
>SB8%2FxCbkoWC_GhQJ
>
>
>[1] http://www.imgtec.com/community/
>[2] e2e.ti.com
>[3]=20
>http://git.omapzoom.org/?p=3Ddevice/ti/proprietary-open.git;a=3Dtree;f=
=3Djacinto
>6;h=3D6203e0dfe7cf89456517a1b877610f8ac2b4fd86;hb=3Drefs/heads/d-lolli=
pop-rele
>ase
>--=20
>Regards,
>Nishanth Menon


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
