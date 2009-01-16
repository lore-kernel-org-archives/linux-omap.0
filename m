From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: lowmemory android driver not needed?
Date: Fri, 16 Jan 2009 20:16:51 +0900
Message-ID: <2f11576a0901160316u20030f4u51c9e4c059398b70@mail.gmail.com>
References: <d6200be20901131830r7103ff8eoe0314f9faf89d89b@mail.gmail.com>
	 <20090114104307.GA20451@elf.ucw.cz>
	 <20090114104834.18387fca@lxorguk.ukuu.org.uk>
	 <d6200be20901141426r1d48ea33gc9a380451e4aaf93@mail.gmail.com>
	 <20090114231739.GB24111@kroah.com>
	 <d6200be20901141532y6f236104kd521041d640c152e@mail.gmail.com>
	 <20090115001224.GC11328@kroah.com>
	 <5d5443650901150532r20a4c25q834afadde2f98a3@mail.gmail.com>
	 <20090115234404.GA20142@kroah.com>
	 <20090116090210.GB7039@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:21605 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbZAPLQv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 06:16:51 -0500
In-Reply-To: <20090116090210.GB7039@linux-sh.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>, Trilok Soni <soni.trilok@gmail.com>, Arve Hj?nnev?g <arve@android.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel

Hi

>> > And there is one more lowmem driver developed by Nokia for Nokia 8xx
>> > tablets it seems. CCed Tony Lindgren,  Juha and Viktor.
>> >
>> > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;f=security/lowmem.c;h=ae78a530af39703e335ad769f1e6f097f63ec6dd;hb=HEAD
>>
>> As we can't stack LSMs, using the lsm interface for a simple memory
>> driver seems pretty wasteful :)
>>
> The heuristics and tunables are more what ended up being useful with this
> module, which could trivially be abstracted out. The focus of the lowmem
> module was mostly giving userspace an opportunity to change its behaviour,
> and to try to save critical state. I don't know how well this would map
> to the Android use cases, though.

This thread is very interesting.

As far as I know, embedded guys strong want to lowmem notification mecanism.
At least, I and my mem_notify receive multiple contact from embedded
and JavaVM developer.
 (include sun javavm engineer)

In ideal, I think linux MM should care this requirement directly.
LSM and driver notifier is easy breakable because these component
deeply depend on MM.

(eg, I developed /dev/mem_notify patch last year. but this patch don't
work on 2.6.28 because
split-lru patch series totally changed MM reclaim processing.)

Unfortunately, we don't have any consensus of memory notification requirement.
various people have various requirement. so, if I can discuss it and
we get consensus, I'm glad.
