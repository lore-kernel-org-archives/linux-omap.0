From: Tony Lindgren <tony@atomide.com>
Subject: Re: Cannot stall an endpoint 0 control transfer from a data stage
	cal lback function
Date: Fri, 24 Aug 2007 05:09:32 -0700
Message-ID: <20070824120931.GN30522@atomide.com>
References: <0474A5584072DA1197F50007E90E6B1141D5E1@PORTIA>
	<200708211658.05301.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200708211658.05301.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: Geoffrey Tam <geoffrey@evertz.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070821 16:58]:
> On Tuesday 21 August 2007, Geoffrey Tam wrote:
> > Sorry for the long delay.
> > 
> > I just tried out the latest code on the git tree, and it does not work for
> > me. It does not allow me to stall an endpoint.
> 
> I was wondering what happened to this problem report ... I cleaned
> up your old patch and fixed some things that were wrong, maybe this
> one will work better.
> 
> - Dave
> 
> 
> 
> ======	CUT HERE
> Gadget drivers are supposed to be able to cause EP0 protocol stalls by
> issuing an appropriate request from the callback issued when the DATA
> stage completes ... not only from the setup() callback or from some
> thread that decides how to handle the request.
> 
> This fix is based on a patch from Geoffrey Tam <geoffrey@evertz.com>,
> and addresses that by updating the endpoint state AFTER the callback
> is issued, providing the correct IRQ-acking CSR to the halt() so it
> can just mask in the SEND_STALL bit, and ensuring that only the CSR
> is still written only once even on this new code path.
> 
> Also includes a few small cleanups:  avoid "this" variable name, and
> pack device bitfields more efficiently (wasting less space).
> 
> Allegedly helps file_storage on Davinci.

I've pushed this as the driver seems to work after the patch :)

Tony
