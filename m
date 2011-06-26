From: Brian Swetland <swetland@google.com>
Subject: Re: [RFC 0/8] Introducing a generic AMP/IPC framework
Date: Sat, 25 Jun 2011 18:17:05 -0700
Message-ID: <BANLkTi=wOGV9jv4XxrLn6FUuBKH0HGxxNw@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<4E04F0B0.4030408@codeaurora.org>
	<BANLkTi=sFtwam29i4TZdi=RO7BoytTTdrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <BANLkTi=sFtwam29i4TZdi=RO7BoytTTdrw@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>, Rusty Russell <rusty@rustcorp.com.au>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Jun 25, 2011 at 6:11 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Stephen,
>
> On Fri, Jun 24, 2011 at 11:16 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> This sounds a lot like SMD (shared memory driver) on MSM. The main
>> difference I see is that SMD uses the platform bus instead of the virtio
>> bus and it has its own protocol for channel allocation.
>
> Yeah, virtio is a key factor in this work; it was suggested to us by
> Arnd at the AMP plumbers discussions last year, where it was apparent
> that many vendors have their own IPC drivers/buses/channels over
> shared memory with some vendor-ish binary protocol. I must say we
> really liked virtio: it considerably simplified the code (we're not
> adding any new binary protocol), it's very nicely optimized and
> flexible, and it comes with a set of virtio drivers (e.g. network,
> console, block) so we don't have to write our own.
>
> We also cared about adding this functionality as an IPC bus, so the
> driver core will help matching drivers to channels - it simplified the
> code (in both setup and tear down of channels) and kept it flexible.
> It will also facilitate error recovery (on remote crash, we just
> remove the virtio device, and then the driver core will in turn start
> ->remove()ing the rpmsg drivers) and power management (via runtime
> PM).
>
> About SMD: I'm not familiar with it too much, but Brian naturally is
> (just for the sake of everyone who are not reading headers - Brian
> Swetland wrote the Linux SMD driver, and is also an author of this
> Google+TI joint work).

rpmsg definitely shares some design features with SMD (given that I
wrote the linux SMD driver and was involved in the design of rpmsg,
this is maybe unsurprising), but whereas in SMD we had to be
compatible with existing AMSS modems (to a degree), we had more
flexibility in the "wire protocol" on rpmsg and virtio looked like a
really nice fit that already was in the kernel.

Ohad had a number of great ideas for making the dynamic discovery,
publishing, and binding of remote services very clean and
straightforward -- I wish I had a chance to pick his brain about this
stuff back when building the SMD interfaces, which started out fairly
static, but then evolved into publishing platform devices, etc.  Of
course some of this is the benefit of hindsight.  It's easier to get
it right (er?) the second or third time around.

The TI SYS/BIOS folks were quite helpful and patient as we redesigned
the wire protocol and publishing/resource model several times along
the way here.

Brian
