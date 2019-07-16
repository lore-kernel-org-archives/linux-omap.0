From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: Add of_node_put() before
 return and break
Date: Tue, 16 Jul 2019 12:37:23 -0700 (PDT)
Message-ID: <20190716.123723.2173742343657007091.davem@davemloft.net>
References: <20190716054843.2957-1-nishkadg.linux@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190716054843.2957-1-nishkadg.linux@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: nishkadg.linux@gmail.com
Cc: grygorii.strashko@ti.com, ivan.khoronzhuk@linaro.org, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Nishka Dasgupta <nishkadg.linux@gmail.com>
Date: Tue, 16 Jul 2019 11:18:43 +0530

> Each iteration of for_each_available_child_of_node puts the previous
> node, but in the case of a return or break from the middle of the loop,
> there is no put, thus causing a memory leak.

What an incredible terribly designed loop macro, this
for_each_available_child_of_node () thing is.

A macro with non-trivial, invisible, side effects.  It requires
special handling of reference counting of objects if the loop is
terminated early.

This is so error prone.  Is it any wonder we have to go through the
entire tree fixing up nearly every use of this thing?

Instead of looking at the automated analysis of this and saying "great
here are all of these places where I can fix bugs", I would instead
appreicate it if the reaction was more like "this interface is
obviously impossible to use in a non-error-prone fashion, we should
fix it."

I guess I have no choice but to apply your fixes, but the larger issue
must be addressed instead.
