From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 25/26] arm: Don't use create_proc_read_entry() [RFC]
Date: Thu, 11 Apr 2013 09:57:03 -0700
Message-ID: <20130411165702.GZ10155@atomide.com>
References: <20130411154806.GU10155@atomide.com>
 <20130411132739.32763.82609.stgit@warthog.procyon.org.uk>
 <20130411133058.32763.5466.stgit@warthog.procyon.org.uk>
 <13448.1365698725@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <13448.1365698725@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, viro@ZenIV.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* David Howells <dhowells@redhat.com> [130411 09:50]:
> Tony Lindgren <tony@atomide.com> wrote:
> 
> > Looks like the mach-omap1/pm.c part we can make into
> > a debugfs entry as it only contains PM debug data. But
> > that we can do after this patch.
> 
> If you have a patch to do that, I can substitute it for this one.

Sure will do.

Tony
