From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 7/8] drivers: introduce rpmsg, a remote-processor
 messaging bus
Date: Thu, 9 Jun 2011 19:12:10 +0200
Message-ID: <20110609171210.GB3877@ucw.cz>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
 <1308640714-17961-8-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1308640714-17961-8-git-send-email-ohad@wizery.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: linux-omap@vger.kernel.org

Hi!

> @@ -0,0 +1,75 @@
> +What:		/sys/bus/rpmsg/devices/.../name
> +Date:		June 2011
> +KernelVersion:	3.2
> +Contact:	Ohad Ben-Cohen <ohad@wizery.com>
> +Description:
> +		Every rpmsg device is a communication channel with a remote
> +		processor. Channels are identified with a (textual) name,
> +		which is maximum 32 bytes long (defined as RPMSG_NAME_SIZE in
> +		rpmsg.h).
> +
> +		This sysfs entry contains the name of this channel.
> +
> +What:		/sys/bus/rpmsg/devices/.../src
> +Date:		June 2011
> +KernelVersion:	3.2
> +Contact:	Ohad Ben-Cohen <ohad@wizery.com>
> +Description:
> +		Every rpmsg device is a communication channel with a remote
> +		processor. Channels have a local ("source") rpmsg address,
> +		and remote ("destination") rpmsg address. When an entity
> +		starts listening on one end of a channel, it assigns it with
> +		a unique rpmsg address (a 32 bits integer). This way when
> +		inbound messages arrive to this address, the rpmsg core
> +		dispatches them to the listening entity (a kernel driver).
> +
> +		This sysfs entry contains the src (local) rpmsg address
> +		of this channel. If it contains 0xffffffff, then an address
> +		wasn't assigned (can happen if no driver exists for this
> +		channel).

So this is basically networking... right? Why not implement it as
sockets? (accept, connect, read, write)?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
