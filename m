From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators for v3.4
Date: Tue, 27 Mar 2012 10:49:32 -0700
Message-ID: <87k426ndcj.fsf@ti.com>
References: <877gywjhht.fsf@ti.com> <20120308021843.GQ12083@atomide.com>
	<87399jc6cj.fsf@ti.com> <20120309003217.GB12083@atomide.com>
	<20120309114731.GA3273@opensource.wolfsonmicro.com>
	<87zkbp4wtj.fsf@ti.com>
	<20120311204232.GC3171@opensource.wolfsonmicro.com>
	<87399dzq5e.fsf@ti.com>
	<20120312173215.GL3110@opensource.wolfsonmicro.com>
	<87pqchv1pc.fsf@ti.com>
	<CANOLnOMfsdGn-B0zftcV-zh+tSCGgmf0g1BsrFB0+Kh-HnNq0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:39032 "HELO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754880Ab2C0Rtd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 13:49:33 -0400
Received: by mail-pb0-f52.google.com with SMTP id uo15so731782pbc.39
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 10:49:32 -0700 (PDT)
In-Reply-To: <CANOLnOMfsdGn-B0zftcV-zh+tSCGgmf0g1BsrFB0+Kh-HnNq0g@mail.gmail.com>
	(Grazvydas Ignotas's message of "Tue, 27 Mar 2012 16:57:40 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Grazvydas Ignotas <notasas@gmail.com> writes:

> On Tue, Mar 13, 2012 at 1:28 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Tony, updated pull request below. =C2=A0This includes all the TWL de=
pencies
>> merged from the 'topic/twl' tag in Mark's tree.
>>
>
> Has this been lost now? It seems regulator parts got merged, but
> voltage parts are missing from Arnd's pull requests and are not
> showing up in linux-next.

Not lost, just delayed.   Due to problems in working out the
dependencies with the regulator core, this pull request was too late to
make it for v3.4.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
