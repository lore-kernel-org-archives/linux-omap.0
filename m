From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: omapfb: help from userspace
Date: Mon, 15 Sep 2008 21:46:59 +0100
Message-ID: <yw1xd4j5xhks.fsf@thrashbarg.mansr.com>
References: <94a0d4530809150738v7638988bnd12901d147a42d1e@mail.gmail.com> <94a0d4530809151324x1dc3069at8f6163188267676f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:34118 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754199AbYIOUrM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Sep 2008 16:47:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KfKyT-0006DF-N0
	for linux-omap@vger.kernel.org; Mon, 15 Sep 2008 20:47:09 +0000
Received: from thrashbarg.mansr.com ([78.86.181.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 15 Sep 2008 20:47:09 +0000
Received: from mans by thrashbarg.mansr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 15 Sep 2008 20:47:09 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

"Felipe Contreras" <felipe.contreras@gmail.com> writes:

> On Mon, Sep 15, 2008 at 5:38 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Hi,
>>
>> I've been trying to get the yuv overlay to work, but without success=
=2E
>> I'm trying to do what Mans Rullgard is doing on omapfbplay[1], but I
>> don't see anything happening.
>>
>> The normal RGB plane is working fine, I'm attaching a test that writ=
es
>> data to the whole framebuffer.
>>
>> This is the output:
>> # /tmp/fb_test
>> main: size=3D720x400, 16bpp
>> overlay: size=3D720x400, 16bpp
>> panel: enabled=3D0
>> panel: 0x0 - 720x400
>> # /tmp/fb_test
>> main: size=3D720x400, 16bpp
>> overlay: size=3D720x400, 16bpp
>> panel: enabled=3D1
>> panel: 0x0 - 720x400
>
> Nevermind, this patch fixed the issue:
> http://gitweb.openembedded.net/?p=3Dorg.openembedded.dev.git;a=3Dblob=
;f=3Dpackages/linux/linux-omap2-git/beagleboard/03-enable-overlay-opt.d=
iff;h=3D9fa749f5fc00a711afc6f31781d45efa885b4ccf;hb=3DHEAD

That patch is bad.  Use this one instead:

http://git.mansr.com/?p=3Dlinux-omap;a=3Dcommitdiff;h=3D7e052af7e4c73dc=
450412486ad37eb529e725dc7

It's still not perfect, but it's better.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
