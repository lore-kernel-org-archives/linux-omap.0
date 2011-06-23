From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 0/8] Introducing a generic AMP/IPC framework
Date: Thu, 23 Jun 2011 20:46:35 +0200
Message-ID: <201106232046.35846.arnd@arndb.de>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com> <4E033041.9090606@criticallink.com> <FFF198FBBF957F4393BA834040FEFFA202CA6E@DFLE35.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <FFF198FBBF957F4393BA834040FEFFA202CA6E@DFLE35.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "Grosen, Mark" <mgrosen@ti.com>, Michael Williamson <michael.williamson@criticallink.com>, Ohad Ben-Cohen <ohad@wizery.com>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>, Brian Swetland <swetland@google.com>, Rusty Russell <rusty@rustcorp.com.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Subhasish Ghosh <subhasish@mistralsolutions.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 23 June 2011 18:27:10 Grosen, Mark wrote:
> First, we are not abandoning DSPLINK. We have many users of this, even
> though it is out-of-tree, and we will continue to support it. That said, we
> do intend to make this new design the basis for DSPLINK-like
> functionality. It's designed to be done "the right way" for Linux (and we
> are looking for feedback to make it better).  It is also designed to be more
> scalable and extensible in userspace. With a solid kernel foundation, we can
> provide lots of functionality in userspace, or users can implement their own
> custom solutions. One of the key things to do is map our existing DSPLINK
> APIs, like MessageQ, to the new rpmsg transport.

Sounds all good. What about the PRUSS code? Does that fit into the new model
as well?

	Arnd
