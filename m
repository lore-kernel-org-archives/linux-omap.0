From: Florian Mickler <florian@mickler.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 20 May 2010 07:15:28 +0200
Message-ID: <20100520071528.494c38e4@schatten.dmk.lab>
References: <1274115885.4418.59.camel@mulgrave.site>
	<20100517174647.GA11512@gandalf>
	<1274119179.4418.68.camel@mulgrave.site>
	<20100517181252.GA14260@gandalf>
	<1274124267.4418.149.camel@mulgrave.site>
	<20100517193840.GB14047@gandalf>
	<20100517193952.GC14047@gandalf>
	<1274125775.4418.182.camel@mulgrave.site>
	<20100518064022.GA6522@nokia.com>
	<1274191188.10304.5.camel@mulgrave.site>
	<20100519065934.GH12879@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100519065934.GH12879@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 19 May 2010 09:59:34 +0300
Felipe Balbi <felipe.balbi@nokia.com> wrote:


> >The corollary is that real world systems have to operate in the face of
> >misbehaving hardware *and* software.
> 
> I still think the kernel shouldn't deal with broken applications and we 
> shouldn't try to fix them in kernel space. We can, of course, try to 
> find them and have all sorts of bells and whistles shouting 'process 
> %s is preventing CPU from sleeping for %llu nanoseconds' or something 
> like that.
> 

But with that, you still shift the burden of exchanging that app with
an feature-equivalent non-broken version to the user. 
which is not user friendly and not necessary if you have a "smart"
enough kernel.

Cheers,
Flo 
