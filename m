From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 0/3] kmemleak: Fix false positive with special scan
Date: Wed, 02 Jun 2010 11:01:24 +0100
Message-ID: <1275472884.13743.29.camel@e102109-lin.cambridge.arm.com>
References: <1273821401-26578-2-git-send-email-Hiroshi.DOYU@nokia.com>
	 <1275387911-13030-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1275387911-13030-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-kernel@vger.kernel.org, ext-phil.2.carmody@nokia.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Sorry for the delay, I eventually got the time to look at your patches.

On Tue, 2010-06-01 at 11:25 +0100, Hiroshi DOYU wrote:
> There is a false positive case that a pointer is calculated by other
> methods than the usual container_of macro. "kmemleak_ignore" can cover
> such a false positive, but it would loose the advantage of memory leak
> detection. This patch allows kmemleak to work with such false
> positives by introducing a new special memory block with a specified
> calculation formula. A client module can register its area with a
> conversion function, with which function kmemleak scan could calculate
> a correct pointer.

While something needs to be done to cover these situations, I'm not so
convinced about the method as it complicates the code requiring such
conversion by having to insert two kmemleak hooks and a callback
function.

Can we not add a new prio tree (or just use the existing one) for
pointer aliases? The advantage is that you only have a single function
to call, something like kmemleak_add_alias() and you do it at the point
the value was converted.

Thanks.

-- 
Catalin
