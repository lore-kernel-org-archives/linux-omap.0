From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: [PATCH] net: ethernet: ti: cpdma: switch to use genalloc
Date: Fri, 24 Jun 2016 14:39:21 -0400
Message-ID: <20160624183921.GB23499@csclub.uwaterloo.ca>
References: <20160623123620.11681-1-grygorii.strashko@ti.com>
 <576BDC64.3030908@linaro.org>
 <576CCD9B.2050700@ti.com>
 <20160624161541.GA23499@csclub.uwaterloo.ca>
 <576D66B8.7040300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <576D66B8.7040300@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 24, 2016 at 07:58:32PM +0300, Grygorii Strashko wrote:
> Oh. nice :( So, seems, I'd need to send v3. Right?
> By the way, this code hasn't been introduced by this patch - I've
> just moved whole function from one place to another.

Well since it is moving I would think that was a handy time to fix the
coding style violation too, since it got noticed.

That leaves just one place in that file violating that part of the coding
style (the other is in cpdma_chan_dump).

Somehow it wasn't spotted when the code was put in back in 2010, and since
they were wrapped lines, they don't stand out quite as much visually.

-- 
Len Sorensen
