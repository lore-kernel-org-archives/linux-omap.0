From: arno@natisbad.org (Arnaud Ebalard)
Subject: Re: N8x0 to mainline patches
Date: Mon, 20 Jul 2009 09:23:49 +0200
Message-ID: <87ocrfhl6i.fsf@small.ssi.corp>
References: <200907191600.23502.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from copper.chdir.org ([88.191.97.87]:49287 "EHLO copper.chdir.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752611AbZGTHXQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Jul 2009 03:23:16 -0400
In-Reply-To: <200907191600.23502.luke@dashjr.org> (Luke-Jr's message of "Sun,
	19 Jul 2009 16:00:19 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke-Jr <luke@dashjr.org>
Cc: linux-omap@vger.kernel.org

Hi,

"Luke-Jr" <luke@dashjr.org> writes:

>> When the rx44 keymap support is added back in your quilt set, can we
>> discuss it. IIRC, the same kind of value (i.e. > 255) is also in the
>> rx-51. Any specific reason?
>
> I presume the reason is that the "standard" code for the "Fn" key is 464... so 
> it is only correct to map "Fn" to KEY_FN. ;)

I know, but from the document I read on the topic, xorg does not support
keycode value higher than 255. I must definitely be missing something.

> There is a software Fn key on some Mac laptops as well. Do they work? Why/how?

My old laptop was a powerbook 12" running Debian and that key never
worked, IIRC.

> Note: before I installed KDE 4 on my N810, Fn was working in X with its usual 
> keycode...

If you manage to find out why/how it worked at some point, I am
interested.

Cheers,

a+
