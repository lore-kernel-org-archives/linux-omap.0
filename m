From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: DSS and HDMI kernel panic on OMAP4
Date: Fri, 16 May 2014 20:48:25 +0200
Message-ID: <CAGhQ9VzJKbyugFCv-4nFpgzNLKbwUhCPDs91z5FZiXrd0EoK-A@mail.gmail.com>
References: <CAGhQ9VyEsX2FmJj4TWgrKMggz=zH--rrVKaztV6AWwLQZTsDUg@mail.gmail.com>
	<CAGhQ9VxU1Zk0Prdq-PwkM=e8W6pZ=JXFa__xjCx4ofCVyWJ0kw@mail.gmail.com>
	<5375A0F8.9000208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:58211 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626AbaEPSs0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2014 14:48:26 -0400
Received: by mail-ve0-f179.google.com with SMTP id oy12so3548710veb.38
        for <linux-omap@vger.kernel.org>; Fri, 16 May 2014 11:48:26 -0700 (PDT)
In-Reply-To: <5375A0F8.9000208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, linux-omap@vger.kernel.org

On 16 May 2014 07:24, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 16/05/14 00:26, Joachim Eastwood wrote:
>> On 15 May 2014 23:14, Joachim  Eastwood <manabian@gmail.com> wrote:
>>> Hello Tomi,
>>>
>>> I wanted to test my Variscite patches after Tony merged them into his
>>> 3.16 dt branch so created a base branch from Linus master and pull in
>>> Tony's 3.16 dt and your dss for-next branch.
>>>
>>> I discovered that booting with a HDMI monitor connected or plugging in
>>> one cause a kernel panic. See the log at:
>>> http://slexy.org/raw/s20xo68UPx
>>>
>>> Any idea what it could be?
>>>
>>> I also noted this in the boot log:
>>> [ 0.984527] omapdss_hdmi 58006000.encoder: can't request region for
>>> resource [mem 0x58006400-0x580073ff]
>>>
>>> I don't think I have seen this before.
>>>
>>> What I previously have tested have been Linus master + my Variscite
>>> patches and your panel-dpi dt + hdmi hpd patches cherry-picked.
>>
>> Reverting "OMAPDSS: HDMI: cleanup ioremaps" 59b3d38a3691396783df108
>> from your for-next branch fixes the problem.
>
> I think that's somehow HDMI audio enabled. I bet if you disable HDMI
> audio, the error goes away.

Yes, disabling HDMI audio config option makes the panic disappear. But
since nothing prevents you from turning on this option this is not a
solution.

> If I cat /proc/iomem, I see:
>
> 58006000-58006fff : omap-hdmi-audio-dai
>   58006200-580062ff : pll
>   58006300-580063ff : phy
>
> Without sound support, I don't get the error and I see:
>
> 58006200-580062ff : pll
> 58006300-580063ff : phy
> 58006400-580073ff : core

With the patch 59b3d38a36913 reverted I actually have 2
"omap-hdmi-audio-dai" entries in iomem:
48046000-48046fff : omap-hdmi-audio-dai
58006000-58006fff : omap-hdmi-audio-dai

The first one disappear after patch 59b3d38a36913 is applied.

> Reverting 59b3d38a3691396783df108e6afbba30656edccb helps, because before
> that patch the hdmi driver didn't actually reserve the regions.
>
> So, I don't really have any idea yet what's going on there, but the
> problem is somewhere around hdmi audio.

I see. Would be nice have this fixed before the stuff hits mainline.

regards
Joachim Eastwood
