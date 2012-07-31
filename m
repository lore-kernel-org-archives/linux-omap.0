From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v3 1/3] ARM: omap: clk: add clk_prepare and clk_unprepare
Date: Mon, 30 Jul 2012 17:31:23 -0700
Message-ID: <CAJOA=zNnLahwhzjE0jkmiax8=kU8O4puJQJ1VbA-gDScawg6jw@mail.gmail.com>
References: <1341224669-15231-1-git-send-email-rnayak@ti.com>
 <1341224669-15231-2-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1207301614590.8722@utopia.booyaka.com>
 <CAJOA=zPmfq+WsAF-7nAkMGghPLYHpd+fCkrsv=3JSWLGMb-zkg@mail.gmail.com> <20120730230233.GA12574@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:42962 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752792Ab2GaAbp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jul 2012 20:31:45 -0400
Received: by yhr47 with SMTP id 47so6531532yhr.14
        for <linux-omap@vger.kernel.org>; Mon, 30 Jul 2012 17:31:44 -0700 (PDT)
In-Reply-To: <20120730230233.GA12574@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

On Mon, Jul 30, 2012 at 4:02 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jul 30, 2012 at 03:42:13PM -0700, Turquette, Mike wrote:
>> On Mon, Jul 30, 2012 at 3:31 PM, Paul Walmsley <paul@pwsan.com> wrote:
>> > So if we make a change like this one, it seems like we would basically
>> > expect it to break once we start doing anything meaningful with
>> > clk_prepare(), like using clk_prepare() for voltage scaling or something
>> > that requires I2C?  We'd also probably want to mark this with some kind of
>> > "HACK" comment.
>>
>> Hi Paul,
>>
>> Did you have anything in mind to start using clk_prepare?  I still
>> hope to get rid of it some day and replace that call with a
>> combination of clk_enable and a check like clk_enable_can_sleep.
>
> Don't you dare.
>
> We arrived at the clk_prepare()/clk_enable() split after lots of
> discussion between different platform maintainers and their
> requirements.
>
> Shoving crap like "clk_enable_can_sleep()" down into drivers is
> totally and utterly idiotic.  We've had the situation *already*
> where some drivers can be used on some platforms but not on others
> because of differences in clk_enable() expectations.
>

How does having a dynamic run-time check cause a generic driver to run
on "some platforms but not on others"?

> Don't go back there.  clk_prepare() and clk_enable() are separate
> calls for a very good reason.  One is sleepable, the other can be
> called from any atomic contexts.

Two calls exist because of context differences.  But in practice they
do the same thing: cause a line to toggle at a rate.  If a run-time
check exists and the framework could handle this gracefully, why would
you still choose the split api?

Regards,
Mike
