From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/2] mfd: twl4030-audio: fix sibling-node lookup
Date: Tue, 14 Nov 2017 19:07:43 +0100
Message-ID: <20171114180743.GB11226@localhost>
References: <20171111153844.16741-1-johan@kernel.org>
 <189caf41-7298-ab1e-6a67-f6ff86fea47f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <189caf41-7298-ab1e-6a67-f6ff86fea47f@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Johan Hovold <johan@kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 13, 2017 at 10:13:42PM +0200, Peter Ujfalusi wrote:
> On 11/11/2017 05:38 PM, Johan Hovold wrote:
> > A helper purported to look up a child node based on its name was using
> > the wrong of-helper and ended up prematurely freeing the parent of-node
> > while leaking any matching node.
> > 
> > To make things worse, any matching node would not even necessarily be a
> > child node as the whole device tree was searched depth-first starting at
> > the parent.
> 
> I think it is the same case as with the twl6040, there were no
> of_get_child_by_name() when this was done...
> 
> Thanks for fixing it!
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks for the acks.

Johan
