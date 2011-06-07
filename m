From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 1/6] omap: iommu: generic iommu api migration
Date: Tue, 7 Jun 2011 15:27:55 +0300
Message-ID: <BANLkTikGvCDhOev02=n3H1pQvF69fn1uuw@mail.gmail.com>
References: <1307053663-24572-1-git-send-email-ohad@wizery.com>
 <201106071122.47804.laurent.pinchart@ideasonboard.com> <BANLkTineGVvmph=Om2FGR_+mkiMW6k7UAw@mail.gmail.com>
 <201106071340.15199.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201106071340.15199.laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hiroshi.DOYU@nokia.com, arnd@arndb.de, davidb@codeaurora.org, Joerg.Roedel@amd.com
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 7, 2011 at 2:40 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> My point is that if the allocator guarantees the alignment (not as a side
> effect of the implementation, but per its API) there's no need to check it
> again. As the alignement is required, we need an allocator that guarantees it
> anyway.

I understand, but I'd still prefer to have an explicit check that the
hardware alignment requirement is met.

There's no cost in doing that (it's a cold path), and even if it would
only fail once and with an extremely broken kernel - it's worth it.
Will save huge amount of debugging pain (think of the poor guy that
will have to debug this...).

Thanks,
Ohad.
