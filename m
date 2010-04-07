From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: ARM: OMAP: Overo: use new gpmc nand infrastructure
Date: Wed, 07 Apr 2010 13:33:53 -0700
Message-ID: <87k4sjatou.fsf@deeprootsystems.com>
References: <h2p5e088bd91004071035pdae7ad0fk4add0731455d921c@mail.gmail.com>
	<87wrwjcg98.fsf@deeprootsystems.com>
	<u2t5e088bd91004071208o10ac1cf3seecb89b4e29c9ac4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:54123 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab0DGUeB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 16:34:01 -0400
Received: by bwz1 with SMTP id 1so1219084bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 07 Apr 2010 13:33:59 -0700 (PDT)
In-Reply-To: <u2t5e088bd91004071208o10ac1cf3seecb89b4e29c9ac4@mail.gmail.com> (Steve Sakoman's message of "Wed\, 7 Apr 2010 12\:08\:17 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org

Steve Sakoman <sakoman@gmail.com> writes:

> On Wed, Apr 7, 2010 at 10:41 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Steve Sakoman <steve@sakoman.com> writes:
>>
>>> From: Steve Sakoman <steve@sakoman.com>
>>>
>>> Signed-off-by: Steve Sakoman <steve@sakoman.com>
>>
>> -ENOCHANGELOG
>>
>> Please add descriptive changelog.  Otherwise, looks like a good
>> cleanup.
>
> I assume you looking for something like:
>
> Restores nand functionality after changes in commit
> 2f70a1e93657bea0baa7d449aa49e44a08582dc8

Personally, I'd rather see a text summary of the commit (plus commit
ID) so I don't have to follow a commit ID unless I really want the
details.  Something like:

"A new GPMC NAND infrastructure was added by commit foo.  This patch
updates Overo NAND functionally to work with those changes."

or similar.  Since the changelogs become permanent git history, it's
important that they be descriptive and useful long after the initial
commits are done and we've all forgotten about the details.

> If so I'll add it after waiting a bit for any other comments.  I
> assume you are also OK with the similar patch for Beagleboard?

Yes, with a good changelog.  ;)


-- Kevin (changelog cop) Hilman
