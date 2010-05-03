From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: mailbox_mach dependency problem
Date: Mon, 3 May 2010 03:16:57 +0300
Message-ID: <z2j94a0d4531005021716i5f1689c3n382dcb6eb30a6c10@mail.gmail.com>
References: <h2g94a0d4531005010747n6ef7b7d0r9b4714d289d61032@mail.gmail.com>
	 <20100501173328.GA4706@gandalf>
	 <w2y94a0d4531005011608kda24768ep87897ec46b39641e@mail.gmail.com>
	 <20100502071354.GA2360@gandalf>
	 <v2k94a0d4531005020557w60b0ca34q3703ddf39d0d82aa@mail.gmail.com>
	 <20100502155903.GA2246@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:60836 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004Ab0ECAQ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 20:16:59 -0400
Received: by ey-out-2122.google.com with SMTP id d26so112815eyd.19
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 17:16:58 -0700 (PDT)
In-Reply-To: <20100502155903.GA2246@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <hiroshi.doyu@gmail.com>

On Sun, May 2, 2010 at 6:59 PM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Sun, May 02, 2010 at 03:57:42PM +0300, Felipe Contreras wrote:
>> Indeed, that was my understanding, but the mailbox doesn't seem to be
>> designed that way. Apparently the driver has an internal linked list
>> of mailboxes, and the platform device registers a bunch of them.
>> Effectively they need each other.
>
> you could make it the other way around. For each registered
> platform_device you instantiate one mailbox and add it to the list on
> the fly, you would probably like to use a list_head for that also
> instead of having your own list implementation.
>
> if you do that, you leave the mbox "instantiation" up to the
> platform_device code. You would simply register several omap-mbox with a
> different id for each mbox you need. Then the name could be sent using a
> well-defined platform_data. Just a suggestion.

First, this is not my code (sounds like you are assuming so).

Now, I thought on doing something like what you suggest, but since I
haven't done anything like it, I thought on asking for ideas just so I
don't end up doing something stupid.

Making multiple platform_device sounds appealing, but the problem is
that there's no 1-to-1 mapping from resources to mailboxes. For
example, all mailboxes seem to share the same memory, and some
mailboxes use the same irq. I don't know if multiple platform_devices
can share the same resources.

What I ended up doing is store all the mailboxes in the platform data.
I didn't know how to store an array of pointers in the pdata, so I
created my own structure for that:
http://article.gmane.org/gmane.linux.ports.arm.omap/34916

You can check the whole patch series here:
http://thread.gmane.org/gmane.linux.ports.arm.omap/34912

Thanks for the comments. Cheers.

-- 
Felipe Contreras
