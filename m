From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3 PM export chip IDCODE, Production ID and Die ID
Date: Tue, 13 Oct 2009 12:51:30 -0700
Message-ID: <636c5030910131251p14057abdobab3ba5bfb0d67f2@mail.gmail.com>
References: <1255359069-9621-1-git-send-email-peter.de-schrijver@nokia.com>
	 <87r5t7ku90.fsf@deeprootsystems.com>
	 <20091013194808.GB12700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:57655 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbZJMTwn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 15:52:43 -0400
Received: by pzk26 with SMTP id 26so9292127pzk.4
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 12:51:30 -0700 (PDT)
In-Reply-To: <20091013194808.GB12700@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, linux-omap@vger.kernel.org

On Tue, Oct 13, 2009 at 12:48 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Kevin Hilman <khilman@deeprootsystems.com> [091013 12:09]:
>> "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:
>>
>> > From: De-Schrijver Peter (Nokia-D/Helsinki) <Peter.De-Schrijver@nokia.com>
>> >
>> > This patch exports the OMAP3 IDCODE, Production ID and Die ID to userspace via
>> > sysfs. This can be used to track down silicon specific issues. The info is
>> > exported via sysfs because it should be possible to include this in corematic
>> > dumps.
>> >
>> > Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
>>
>> Please export these via debugfs.
>
> I don't think we want to export unique chip identifiers by default.
>

Right, which is why I suggested using debugfs, which is something that
probably wouldn't be enabled/exported on default production kernels.

Kevin
