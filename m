From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 4/6] ARM: move SH-mobile runtime PM to arm/common for sharing with other platforms
Date: Thu, 07 Apr 2011 10:08:41 -0700
Message-ID: <8739lu9eg6.fsf@ti.com>
References: <1302134569-22825-1-git-send-email-khilman@ti.com>
	<1302134569-22825-5-git-send-email-khilman@ti.com>
	<20110407165654.GD8052@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110407165654.GD8052@linux-sh.org> (Paul Mundt's message of
	"Fri, 8 Apr 2011 01:56:54 +0900")
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@suse.com>, Grant Likely <grant.likely@secretlab.ca>, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-omap@vger.kernel.org

Paul Mundt <lethal@linux-sh.org> writes:

> On Wed, Apr 06, 2011 at 05:02:47PM -0700, Kevin Hilman wrote:
>> There is really nothing SH-mobile specific about this runtime PM
>> implementation.  Any platform wanting to implement runtime PM based on
>> simple clock gating can use this implementation.
>> 
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> This observation is wholly architecture agnostic, so it's not clear that
> keeping it in arch/arm/common is any better. It seems that this would be
> better suited for drivers/base/power/ with a generic Kconfig symbol.

Sounds fine to me.

Thanks for the review,

Kevin
