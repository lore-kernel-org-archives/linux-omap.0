From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: Re: [PATCH 0/5] staging: tidspbridge: for 3.9
Date: Sun, 20 Jan 2013 17:49:57 -0600
Message-ID: <CAJ6Av5PGEw=7HNs8HMPgCru7vaYg=aNdk2N4tPhNNN_qjUetPA@mail.gmail.com>
References: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
	<20130118004746.GA8897@kroah.com>
	<20130118020122.GB15361@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:54518 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206Ab3ATXt6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Jan 2013 18:49:58 -0500
Received: by mail-ie0-f176.google.com with SMTP id 13so8942870iea.21
        for <linux-omap@vger.kernel.org>; Sun, 20 Jan 2013 15:49:57 -0800 (PST)
In-Reply-To: <20130118020122.GB15361@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, Chen Gang <gang.chen@asianux.com>, linux-omap@vger.kernel.org

Hi Tony,

On Thu, Jan 17, 2013 at 8:01 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [130117 16:51]:
>> On Thu, Jan 10, 2013 at 03:36:57AM -0600, Omar Ramirez Luna wrote:
>> > Patches for staging-next, fixing comments and suggestions provided
>> > by Chen Gang.
>> >
>> > There is an additional scm patch, that removes hardcoded defines
>> > related to direct register handling for SCM, it was dependent on
>> > changes that already made it to mainline.
>>
>> What is the status on getting this out of the staging tree?  What needs
>> to be done still?
>
> Omar, please correct me if I'm wrong. This thing should be reimplemented
> using remoteproc AFAIK.

tidspbridge might be able to use remoteproc, however it can't get rid
of all the infrastructure to support the SN interface, given that the
SN and firmware are distributed as binaries.

OTOH, remoteproc can also implement support for omap3 dsp, but the
major drawback is that we will lose the distributed codecs along with
gst-dsp support.

> But I doubt that anybody is working on making it happen?

I'm not aware of anybody working on remoteproc for omap3 (eventually I
could pick it up) but I'm more focused on getting tidspbridge out of
staging right now.

Cheers,

Omar
