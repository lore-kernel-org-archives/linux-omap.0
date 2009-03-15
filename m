From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH 1/4] ARM: OMAP3: Add SMSC911X support to Overo platform
	(V2)
Date: Sun, 15 Mar 2009 10:13:47 -0700
Message-ID: <5e088bd90903151013i1b0e57d3hfe37353540b235e1@mail.gmail.com>
References: <20090313224259.8810.3283.stgit@localhost>
	 <20090313224453.8810.41743.stgit@localhost>
	 <20090315153827.GA10541@n2100.arm.linux.org.uk>
	 <5e088bd90903150936w45e68b63k1252cea38b48a5fc@mail.gmail.com>
	 <20090315170054.GA12265@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:32163 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbZCORNt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 13:13:49 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1462554wfa.4
        for <linux-omap@vger.kernel.org>; Sun, 15 Mar 2009 10:13:47 -0700 (PDT)
In-Reply-To: <20090315170054.GA12265@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Sun, Mar 15, 2009 at 10:00 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Mar 15, 2009 at 09:36:25AM -0700, Steve Sakoman wrote:
>> On Sun, Mar 15, 2009 at 8:38 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Mar 13, 2009 at 03:44:53PM -0700, Tony Lindgren wrote:
>> >> Gumstix will soon be shipping a variant of their Summit board tha=
t
>> >> includes an SMSC LAN9221 ethernet interface. =A0This patch provid=
es
>> >> support via the smsc911x driver when enabled in kernel config.
>> >
>> > Does this actually work with the smsc911x driver which is in mainl=
ine,
>> > or is it dependent on the smsc911x patches from Steve Glendinning?
>>
>> For the shipping Overo kernel, I build with 2 of Steve's patches, co=
pied below.
>
> That doesn't help answer the question. =A0What we need to know is whe=
ther
> this patch works alone? =A0If not, do we know for sure that Steve's p=
atches
> are going in during the next merge window?

It does not work without the 2 mentioned patches (IRQ's never get handl=
ed).

I have no idea on the status of Steve's patches re: next merge window.
 To my eyes, they seem fairly important for a functional driver :-)

Steve

> If it doesn't work alone _and_ Steve's patches aren't for whatever re=
ason
> going in (via the net tree), then this patch should be dropped from t=
he
> set.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
