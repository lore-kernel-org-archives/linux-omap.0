From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] mtd: make onenand/generic.c more generic
Date: Fri, 7 Aug 2009 14:46:34 +0900
Message-ID: <aec7e5c30908062246m2ef5b13dv57dd05bd07d23d67__19186.9460199543$1249624010$gmane$org@mail.gmail.com>
References: <20090804092046.16025.83910.sendpatchset@rx1.opensource.se>
	 <9c9fda240908042124y4f783dfehd575601c0a09550e@mail.gmail.com>
	 <aec7e5c30908042141l18b25ba4l66b3cb309f080b21@mail.gmail.com>
	 <aec7e5c30908062228g737c1f6cr25f6c67c07d80bd9@mail.gmail.com>
	 <20090807053020.GA902@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f196.google.com ([209.85.221.196]:49221 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbZHGFqd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 01:46:33 -0400
In-Reply-To: <20090807053020.GA902@linux-sh.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Kyungmin Park <kmpark@infradead.org>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org, tony@atomide.com

On Fri, Aug 7, 2009 at 2:30 PM, Paul Mundt<lethal@linux-sh.org> wrote:
> On Fri, Aug 07, 2009 at 02:28:01PM +0900, Magnus Damm wrote:
>> On Wed, Aug 5, 2009 at 1:41 PM, Magnus Damm<magnus.damm@gmail.com> wrote:
>> >> On Tue, Aug 4, 2009 at 6:20 PM, Magnus Damm<magnus.damm@gmail.com> wrote:
>> >>> From: Magnus Damm <damm@igel.co.jp>
>> >>>
>> >>> This patch removes the ARM dependency from the generic "onenand"
>> >>> platform device driver. This change makes the driver useful for
>> >>> other architectures as well. Needed for the SuperH kfr2r09 board.
>> >
>> Any update on this?
>>
> You have failed at reading your email:
>
> http://lists.infradead.org/pipermail/linux-mtd/2009-August/026805.html
> http://lists.infradead.org/pipermail/linux-mtd/2009-August/026809.html

As usual, sorry about that. I'll solve that soon enough by signing off
with a different address.

/ magnus
