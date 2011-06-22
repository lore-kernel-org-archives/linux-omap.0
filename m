From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [RFC 7/8] drivers: introduce rpmsg, a remote-processor
 messaging bus
Date: Tue, 21 Jun 2011 23:11:27 -0400
Message-ID: <1308712287.11435.4.camel@lappy>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	 <1308640714-17961-8-git-send-email-ohad@wizery.com>
	 <87liwu8u3q.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87liwu8u3q.fsf@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 2011-06-22 at 12:12 +0930, Rusty Russell wrote:
> > +#define VIRTIO_ID_RPMSG		10 /* virtio remote processor messaging */
> 
> I think you want 6.  Plan 9 jumped ahead to grab 9 :)

Maybe it's worth adding an appendix to the virtio spec as part of this
(and really any) patch series which takes a virtio ID.

Also, I understand that virtio itself as an idea isn't Linux specific,
but maybe it's worth including the spec (or at least a variation of it)
as part of the kernel documentation.

-- 

Sasha.
