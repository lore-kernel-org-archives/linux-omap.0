From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] i2c: omap: fix OOPS in omap_i2c_unidle() during probe
Date: Fri, 16 Apr 2010 12:47:50 +0300
Message-ID: <n2m6ed0b2681004160247o7cddd774sd199ea0eb51c9946@mail.gmail.com>
References: <1269339176-17479-1-git-send-email-ext-mika.1.westerberg@nokia.com>
	 <alpine.DEB.2.00.1003310427180.14436@utopia.booyaka.com>
	 <20100331152700.17695375.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:64966 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab0DPJrw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 05:47:52 -0400
In-Reply-To: <20100331152700.17695375.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
Cc: Paul Walmsley <paul@pwsan.com>, Mika Westerberg <ext-mika.1.westerberg@nokia.com>, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Cory Maccarrone <darkstar6262@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>, Jean Delvare <khali@linux-fr.org>, Tony Lindgren <tony@atomide.com>

On Wed, Mar 31, 2010 at 3:27 PM, Jarkko Nikula <jhnikula@gmail.com> wro=
te:
> On Wed, 31 Mar 2010 04:27:41 -0600 (MDT)
> Paul Walmsley <paul@pwsan.com> wrote:
>
>> > This patch moves register shift setting before any register access=
es are done.
>> >
>> > Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
>> > Cc: Cory Maccarrone <darkstar6262@gmail.com>
>>
>> Tested-by: Paul Walmsley <paul@pwsan.com>
>>
> BTW, Tony had the same fix buried in an another thread:
>
> http://marc.info/?l=3Dlinux-omap&m=3D126826012627677&w=3D2
>
> You could add my tested by as well to which one goes in but the fix
> should go for 2.6.34 as the mainline doesn't boot otherwise on OMAP.

Uhm why does this patch (or Tony's version) doesn't reach mainline for
so long? It's critical for all OMAPs except the very old ones.

If it helps:
Tested-by: Grazvydas Ignotas <notasas@gmail.com>

>
> Tested-by: Jarkko Nikula <jhnikula@gmail.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
