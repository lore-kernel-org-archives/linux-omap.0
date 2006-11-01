From: Andrew Morton <akpm@osdl.org>
Subject: Re: Invalid Storage Class BUG
Date: Wed, 1 Nov 2006 14:41:06 -0800
Message-ID: <20061101144106.d6d464a6.akpm@osdl.org>
References: <4549087F.5070701@nokia.com> <85ejsmn99r.fsf@orfeo.duckcorp.org>
	<200611011426.28869.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <200611011426.28869.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <greg@kroah.com>, linux-omap-open-source@linux.omap.com, linux-usb-devel@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

On Wed, 1 Nov 2006 14:26:26 -0800
David Brownell <david-b@pacbell.net> wrote:

> So here's a standard format patch.  This should get into 2.6.19 IMO.

-> Greg.

> (Andrew, ISTR that a topological sort won't work in this file.)

I did one just then.  It worked for allmodconfig, but it was too big so I
deleted it.
