From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: Re: [PATCH 0/5] staging: tidspbridge: for 3.9
Date: Sun, 20 Jan 2013 17:45:16 -0600
Message-ID: <CAJ6Av5M1o9CW=pfWTw_8HY7rfW4sPi6P+p3NY2Q1YErTeptfww@mail.gmail.com>
References: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
	<20130118004746.GA8897@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:46213 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206Ab3ATXpR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Jan 2013 18:45:17 -0500
Received: by mail-ie0-f182.google.com with SMTP id s9so8952344iec.27
        for <linux-omap@vger.kernel.org>; Sun, 20 Jan 2013 15:45:16 -0800 (PST)
In-Reply-To: <20130118004746.GA8897@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, Chen Gang <gang.chen@asianux.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi Greg,

On Thu, Jan 17, 2013 at 6:47 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Jan 10, 2013 at 03:36:57AM -0600, Omar Ramirez Luna wrote:
>> Patches for staging-next, fixing comments and suggestions provided
>> by Chen Gang.
>>
>> There is an additional scm patch, that removes hardcoded defines
>> related to direct register handling for SCM, it was dependent on
>> changes that already made it to mainline.
>
> What is the status on getting this out of the staging tree?

I'm currently working to do this.

>  What needs
> to be done still?

- There is a tasklet that I'm working to remove.
- Some portions could be fitted into remoteproc (as Tony mentions).
- Migration to generic iommu framework.
- Need to rework patches to use request_firmware.
- And a thorough cleanup to get rid of if-else nesting.

At some point I should be able to work on all the items (since I have
the time), but any help is appreciated.

Cheers,

Omar
