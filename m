From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: ARM: CONFIG_FRAME_POINTER
Date: Wed, 13 May 2009 11:09:07 -0700
Message-ID: <87d4ac6fjw.fsf@deeprootsystems.com>
References: <7B4574D56E4ADF438756313E9A172A87396257F0@dlee01.ent.ti.com>
	<87zldhaoco.fsf@deeprootsystems.com>
	<7B4574D56E4ADF438756313E9A172A87396A1DF6@dlee01.ent.ti.com>
	<8763g57ydn.fsf@deeprootsystems.com>
	<7B4574D56E4ADF438756313E9A172A87396A2052@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:1554 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760124AbZEMSJL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 14:09:11 -0400
Received: by wf-out-1314.google.com with SMTP id 26so537109wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 13 May 2009 11:09:12 -0700 (PDT)
In-Reply-To: <7B4574D56E4ADF438756313E9A172A87396A2052@dlee01.ent.ti.com> (Jon Hunter's message of "Wed\, 13 May 2009 13\:05\:22 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Hunter, Jon" <jon-hunter@ti.com> writes:

> Hi Kevin,
>
>> Yes.  Do you mind sending a patch to linux-arm-kernel?
>
> Sure. Does Russell King maintain a git tree for linux-arm or do you
> have any advice which tree I should use to base a patch on for the
> linux-arm folks?

Just base it at Linus' master branch or the latest -rc tag.

Kevin
