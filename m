From: James Carlson <carlsonj@workingcode.com>
Subject: Re: ppp on 2.6.18
Date: Mon, 16 Jun 2008 10:13:10 -0400
Message-ID: <18518.29942.550676.275051@gargle.gargle.HOWL>
References: <a1d91fa0806160536r646577e2n7099431aa934a556@mail.gmail.com>
	<48566242.1080306@katalix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ppp-owner@vger.kernel.org>
In-Reply-To: James Chapman's message of 16 June 2008 13:53:22
Sender: linux-ppp-owner@vger.kernel.org
To: James Chapman <jchapman@katalix.com>
Cc: mohammed shareef <mdshareef@gmail.com>, omap <linux-omap@vger.kernel.org>, linux-ppp@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

James Chapman writes:
> mohammed shareef wrote:
> > Dear all,
> > 
> > i have enabled ppp services when configuring the kernel 2.6.18.
> > 
> > the kernel bootup  of omap5912 osk says this:
> > 
> > PPP generic driver version 2.4.2
> > PPP Deflate Compression module registered
> > PPP BSD Compression module registered
> > 
> > but when i type "pppd -h" in the osk console i get:
> > 
> > # pppd -h
> > -sh: pppd: not found
> 
> You don't have the userspace pppd installed.

Or your path is such that the shell cannot find it.

-- 
James Carlson         42.703N 71.076W         <carlsonj@workingcode.com>
