From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: ARM: OMAP: Overo: use new gpmc nand infrastructure
Date: Wed, 7 Apr 2010 12:08:17 -0700
Message-ID: <u2t5e088bd91004071208o10ac1cf3seecb89b4e29c9ac4@mail.gmail.com>
References: <h2p5e088bd91004071035pdae7ad0fk4add0731455d921c@mail.gmail.com>
	 <87wrwjcg98.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:41404 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab0DGTIS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 15:08:18 -0400
Received: by qyk9 with SMTP id 9so1543784qyk.1
        for <linux-omap@vger.kernel.org>; Wed, 07 Apr 2010 12:08:17 -0700 (PDT)
In-Reply-To: <87wrwjcg98.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

On Wed, Apr 7, 2010 at 10:41 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Steve Sakoman <steve@sakoman.com> writes:
>
>> From: Steve Sakoman <steve@sakoman.com>
>>
>> Signed-off-by: Steve Sakoman <steve@sakoman.com>
>
> -ENOCHANGELOG
>
> Please add descriptive changelog.  Otherwise, looks like a good
> cleanup.

I assume you looking for something like:

Restores nand functionality after changes in commit
2f70a1e93657bea0baa7d449aa49e44a08582dc8

If so I'll add it after waiting a bit for any other comments.  I
assume you are also OK with the similar patch for Beagleboard?

Steve
