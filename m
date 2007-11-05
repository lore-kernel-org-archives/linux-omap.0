From: David Brownell <david-b@pacbell.net>
Subject: Re: USB device DMA support on OMAP2
Date: Sun, 04 Nov 2007 22:24:08 -0800
Message-ID: <20071105062408.46E6423CA67@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20071105053815.GA2036@party>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756237AbXKEGYV@vger.kernel.org>
In-Reply-To: <20071105053815.GA2036@party>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com
Cc: tony@atomide.com
List-Id: linux-omap@vger.kernel.org

> The current omap udc dosen't support the DMA mode

It most certainly does!!  I think you it has DMA issues on OMAP2.


> and it has some problem at setup time on OMAP2 with previous patch file.
> I found that the code assumes bulk out required the big data transfer.
> But MODE SELECT(6) sent the only 24 bytes. it makes a problem.
> So I implement the small packets handling for it.
>
> It is tested with both linux and windows.
>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

I'll have a look at it, thanks.

Is this aginst the linux-omap tree, or current kernel.org code?
(There _shouldn't_ be any differences, but I've not checked in
some time now and such issues do creep in from time to time.)

- Dave
