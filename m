From: "Kyungmin Park" <kmpark@infradead.org>
Subject: Re: USB device DMA support on OMAP2
Date: Mon, 5 Nov 2007 15:31:43 +0900
Message-ID: <9c9fda240711042231s1f698683o20eb5332879d3ec5@mail.gmail.com>
References: <20071105053815.GA2036@party>
	 <20071105062408.46E6423CA67@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754562AbXKEGby@vger.kernel.org>
In-Reply-To: <20071105062408.46E6423CA67@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 11/5/07, David Brownell <david-b@pacbell.net> wrote:
> > The current omap udc dosen't support the DMA mode
>
> It most certainly does!!  I think you it has DMA issues on OMAP2.
>

Ah, Yes, OMAP1 supports the DMA mode. It means the OMAP2 DMA support.

>
> > and it has some problem at setup time on OMAP2 with previous patch file.
> > I found that the code assumes bulk out required the big data transfer.
> > But MODE SELECT(6) sent the only 24 bytes. it makes a problem.
> > So I implement the small packets handling for it.
> >
> > It is tested with both linux and windows.
> >
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> I'll have a look at it, thanks.
>
> Is this aginst the linux-omap tree, or current kernel.org code?
> (There _shouldn't_ be any differences, but I've not checked in
> some time now and such issues do creep in from time to time.)
>

There's some difference related with double buffering.
It's against the latest kernel code. I checked it.

Thank you,
Kyungmin Park
