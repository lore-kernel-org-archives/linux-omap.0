From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 04/19] ARM: OMAP4: PM: save/restore all DPLL settings in OFF mode
Date: Wed, 30 May 2012 10:59:58 -0700
Message-ID: <87wr3t8s81.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-5-git-send-email-t-kristo@ti.com>
	<87d363928g.fsf@ti.com>
	<CAMQu2gw5myvyvM8x225KnN59vEYBYLBiEsvML8RAoE0t+RrbYA@mail.gmail.com>
	<CAMQu2gywor2o+g8Fn80ogbTtEZPSXM74M65GsO2zH44tg-W7gQ@mail.gmail.com>
	<CAOMWX4ctJcfGNxXK4hT+QH-m7zUfP1N3H56oVDVzPFmhVTFOMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:53807 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757180Ab2E3SAO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 May 2012 14:00:14 -0400
Received: by pbbrq2 with SMTP id rq2so299735pbb.34
        for <linux-omap@vger.kernel.org>; Wed, 30 May 2012 11:00:00 -0700 (PDT)
In-Reply-To: <CAOMWX4ctJcfGNxXK4hT+QH-m7zUfP1N3H56oVDVzPFmhVTFOMw@mail.gmail.com>
	(Nishanth Menon's message of "Tue, 29 May 2012 14:46:55 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

"Menon, Nishanth" <nm@ti.com> writes:

> On Thu, May 17, 2012 at 3:52 AM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
>> On Thu, May 17, 2012 at 12:34 PM, Shilimkar, Santosh
>> <santosh.shilimkar@ti.com> wrote:
>>> On Thu, May 17, 2012 at 4:12 AM, Kevin Hilman <khilman@ti.com> wrot=
e:
>>>> Tero Kristo <t-kristo@ti.com> writes:
>>>>
> [...]
>>>> - Rather than hooking into omap4_enter_lowpower(), should use
>>>> =C2=A0the cluster PM enter/exit notifier chain.
>>>>
>>> This is again specific to device OFF only and not related to CPU
>>> cluster state as such. So I don't think notifiers should be used he=
re.
>>>
>>> O.w even when we attempt just MPU OSWR C-state, all these functions=
 will
>>> get called in notifier chain.
>>>
>> Just a thought, we can have a separate notifier chain for device OFF=
=2E It can
>> allow use to get rid of 'enable_off_mode" kind of flags and can be
>> used by many drivers too.
>
> Like the overall idea, but one minor dumb concern might be sequencing
> of notifiers
>  - OFF entry and restore needs things to be executed in a specific se=
quence.
> How do we plan to ensure the sequence is maintained in a notifier cal=
l
> chain? one
> possible option might be a "priority" based scheme?

Or just combine the events that need a specific sequence into single
notifier callback function.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
