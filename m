From: Barry Song <21cnbao@gmail.com>
Subject: Re: the Usage of ROM and RAM of Cortex-M3 on OMAP4
Date: Tue, 21 May 2013 23:55:32 +0800
Message-ID: <CAGsJ_4w-ZCRtK4-ZQkcvfj5fQp38B1tSkPX0k4zji6_0NBkdAA@mail.gmail.com>
References: <CAGsJ_4x+TC04ajK5DYV8CSvRk6xvnmATuj35ruetWjMgLAYcbQ@mail.gmail.com>
 <CAOT3miLBOT2h7758bQDyTm5mNXPcjfFYoADGqS7Set9CwPexTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:34087 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456Ab3EUPzx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 May 2013 11:55:53 -0400
Received: by mail-qa0-f44.google.com with SMTP id hu16so2272971qab.3
        for <linux-omap@vger.kernel.org>; Tue, 21 May 2013 08:55:52 -0700 (PDT)
In-Reply-To: <CAOT3miLBOT2h7758bQDyTm5mNXPcjfFYoADGqS7Set9CwPexTQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Dechesne <ndec13@gmail.com>
Cc: "pandaboard@googlegroups.com" <pandaboard@googlegroups.com>, linux-omap@vger.kernel.org

Hi Nicolas,
thanks very much for your reply.

2013/5/21 Nicolas Dechesne <ndec13@gmail.com>:
> On Tue, May 21, 2013 at 12:04 PM, Barry Song <21cnbao@gmail.com> wrote:
>> Hi All,
>> typically on OMAP4, Cortex-A9 will load the Cortex-M3 firmware and let
>> M3 run from the firmware. for example, on Android, Linux kernel will
>> use remoteproc module to load ducati-m3-core0.xem3 of Ducati.
>> but after reading the datasheet of OMAP4, there are internal 16KB ROM
>> and 64KB RAM for Cortex-M3. And the ROM is bootable. I'd like to know
>> who is using the embedded ROM and RAM and how they use. and can the
>> Cortex-M3 boot from ROM directly by itself?
>>
>
>
> i don't think the ROM is being used. at least i am not aware of anyone
> who would have developed a ROM code for Ducati... so i don't think you
> can use the ROM. as for the RAM if you refer to what's called 'SL2
> memory', it's being used by the codecs (IVAHD), it's just RAM that can
> be used freely if you don't use IVAHD.

if nobody can use the ROM, is bootrom firmware or something else in
OMAP4 using it? so what's the purpose of this ROM? the ROM is said
bootable, but we only boot M3 by Cortex-A9.

-barry
