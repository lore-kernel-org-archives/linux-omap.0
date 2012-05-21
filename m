From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2 14/19] ARM: OMAP4: wakeupgen: enable clocks for save_secure_all
Date: Mon, 21 May 2012 15:09:38 +0530
Message-ID: <CAMQu2gx7NL0Hv9GVtX=WDJY8sB8NoX4oN390NurQ0gvRa=WPYg@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-15-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1205161809230.2921@utopia.booyaka.com>
 <1337592906.28274.16.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:38759 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757184Ab2EUJkA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:40:00 -0400
Received: by qcro28 with SMTP id o28so3893826qcr.33
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 02:39:59 -0700 (PDT)
In-Reply-To: <1337592906.28274.16.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Mon, May 21, 2012 at 3:05 PM, Tero Kristo <t-kristo@ti.com> wrote:
> On Wed, 2012-05-16 at 18:17 -0600, Paul Walmsley wrote:
>> Hi Tero
>>
>> On Mon, 14 May 2012, Tero Kristo wrote:
>>
>> > save_secure_all needs l3_main_3_ick and l4_secure_clkdm enabled,
>> > otherwise the secure ROM code will crash.
>>
>> Do we know why the l3_main_3 interconnect has to be enabled? =A0Is t=
his
>> needed to access some L3 or instrumentation registers?
>
> Not sure, ROM code is doing something here which requires it, and the
> ROM code definitely crashes without this. Your guess sounds plausible=
=2E
>
ROM code accesses L3 firewall registers mostly apart from L2 INSTR fire=
wall
registers here and without that clock, those accesses will abort.

Regards
santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
