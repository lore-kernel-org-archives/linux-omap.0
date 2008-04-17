From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] ARM: OMAP: CLKFW: Initial debugfs support for omap clock framework
Date: Thu, 17 Apr 2008 11:54:02 -0700
Message-ID: <200804171154.02983.david-b@pacbell.net>
References: <20080416205119.GF17055@atomide.com> <200804171140.59906.david-b@pacbell.net> <alpine.DEB.1.00.0804171243340.8530@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:39292 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752226AbYDQSyF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Apr 2008 14:54:05 -0400
In-Reply-To: <alpine.DEB.1.00.0804171243340.8530@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org

On Thursday 17 April 2008, Paul Walmsley wrote:
> Hello David,
> 
> On Thu, 17 Apr 2008, David Brownell wrote:
> 
> > On Thursday 17 April 2008, Paul Walmsley wrote:
> > > But it would be nice to be able to call into clock functions like 
> > > round_rate, set_rate, and set_parent via filesystem writes for debugging 
> > > purposes, and I don't think that debugfs supports this.
> > 
> > It does, if you set up the files properly ... except
> > maybe the set_parent stuff.
> 
> Could you be more specific?  The only write support that I see in the 
> debugfs API is to store bytes into memory locations.  We'd need to call 
> functions also upon writes.

struct dentry *debugfs_create_file(const char *name, mode_t mode,
                                   struct dentry *parent, void *data,
                                   const struct file_operations *fops);

... provide a file_operations vector supporting writes.  Or building
more complex values with seq_file, etc.

There are indeed lots of functions letting you create single-valued
attributes.  I happen to find that model uselessly constraining,
and can't really imagine using it.

- Dave

