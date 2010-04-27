From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP: DSS: ensure clocks are disabled on failed init
Date: Tue, 27 Apr 2010 08:13:34 -0700
Message-ID: <87mxwpq675.fsf@deeprootsystems.com>
References: <1272309166-698-1-git-send-email-khilman@deeprootsystems.com>
	<p2x6ed0b2681004270214yc64459e4g2e0d15dcac84bd2@mail.gmail.com>
	<1272364829.2529.109.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44247 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab0D0PNo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 11:13:44 -0400
Received: by pvg2 with SMTP id 2so1345251pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 08:13:43 -0700 (PDT)
In-Reply-To: <1272364829.2529.109.camel@tubuntu.research.nokia.com> (Tomi Valkeinen's message of "Tue\, 27 Apr 2010 13\:40\:29 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tomi Valkeinen <tomi.valkeinen@nokia.com> writes:

> Hi,
>
> On Tue, 2010-04-27 at 11:14 +0200, ext Grazvydas Ignotas wrote:
>> CC Tomi in case he missed this.
>
> Thanks =)
>
>> 
>> On Mon, Apr 26, 2010 at 10:12 PM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>> > Currently, if init fails for whatever reason, various DSS related
>> > clocks will be left enabled and prevent the chip from hitting
>> > retention or off-mode.
>> >
>> > This patch ensures the clocks are disabled on a failed init.
>> >
>> > For this to work, a check had to be added to dispc_save_context()
>> > to not save context if it has not yet been initialized.
>
> The code in omap_dss_probe() is actually quite broken, as the /* XXX
> fail correctly */ hints... At least clocks should be put(), debugfs
> should be uninitialized etc. So this patch is ok quick fix, but I'll try
> to find time to fix the fail path properly.

Thanks.  My main concern of course is that any failed init will ensure
clocks are disabled and the modules are able to idle.

Kevin
