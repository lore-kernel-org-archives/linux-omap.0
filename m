From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] omap: rx51: mark reserved memory earlier
Date: Thu, 10 Feb 2011 16:40:25 +0200
Message-ID: <AANLkTikPp6hin3FAYNJG33_ac295UpJZy+146Et+b=fJ@mail.gmail.com>
References: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
	<1287146784-5517-2-git-send-email-felipe.contreras@gmail.com>
	<1289568492.3297.277.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47035 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829Ab1BJOk1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Feb 2011 09:40:27 -0500
Received: by fxm20 with SMTP id 20so1542034fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 06:40:26 -0800 (PST)
In-Reply-To: <1289568492.3297.277.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, "mike@compulab.co.il" <mike@compulab.co.il>, Russell King <linux@arm.linux.org.uk>

On Fri, Nov 12, 2010 at 3:28 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> On Fri, 2010-10-15 at 14:46 +0200, ext Felipe Contreras wrote:
>> So that omap_vram_set_sdram_vram() is called before
>> omap_vram_reserve_sdram_memblock().
>
> Is this still valid after the latest memblock stuff? I presume it is.
> I'm not able to test this, and you said you didn't test it, so I'm a bit
> uneasy about applying =).

This has been tested on other boards. Can you apply?

-- 
Felipe Contreras
