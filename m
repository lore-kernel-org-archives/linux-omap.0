From: Nishanth Menon <nm@ti.com>
Subject: Re: SGX support on AM572x
Date: Tue, 11 Nov 2014 13:54:03 -0600
Message-ID: <20141111195403.GA16958@kahuna>
References: <D087A0BB.5A41E%john3909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53560 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbaKKTyF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Nov 2014 14:54:05 -0500
Content-Disposition: inline
In-Reply-To: <D087A0BB.5A41E%john3909@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Syn <john3909@gmail.com>
Cc: linux-omap@vger.kernel.org

On 11:17-20141111, John Syn wrote:
> With the release of the Beagleboard-X15 in February 2015, I=B9m tryin=
g to
> get a handle on the status of SGX support for the AM572x processor. I=
s
> anyone working on adding this support and is there any schedule for
> releasing SGX on AM572x? There is a lot of interest on the beagleboar=
d
> mailing list, but SGX support seems to be a big stumbling block.

1. Are you looking for SGX driver support in https://git.kernel.org/cgi=
t/linux/kernel/git/torvalds/linux.git/ ?

OR

2. Are you looking for distro support?

OR
3. Are you looking for what TI release(if any) will contain?

for (1) you already have response from beagleboard mailing list - TI, t=
o
my knowledge will not support IMG[1] drivers in kernel.org - at least n=
o
known activity in the past present or future to do that.

=46or (2): as the distro folks how they want to do things - again depen=
ds
on where you are getting your distro from.

=46or (3): use TI support channel over e2e Phorums[2] and look at relev=
ant
TI release's release notes. Things like [3] are handled properly that
way.


Other recent references:
https://plus.google.com/100242854243155306943/posts/TKX7GfHkTow
http://beagleboard.org/Community/Forums?place=3Dmsg%2Fbeagleboard%2F1t3=
yxkPYSB8%2FxCbkoWC_GhQJ


[1] http://www.imgtec.com/community/
[2] e2e.ti.com
[3] http://git.omapzoom.org/?p=3Ddevice/ti/proprietary-open.git;a=3Dtre=
e;f=3Djacinto6;h=3D6203e0dfe7cf89456517a1b877610f8ac2b4fd86;hb=3Drefs/h=
eads/d-lollipop-release
--=20
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
