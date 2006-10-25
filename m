From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.18-omap-git] omap2 fullspeed usb 1/2
Date: Wed, 25 Oct 2006 21:45:10 +0300
Message-ID: <20061025184508.GK4852@atomide.com>
References: <001c01c6f65d$f2d11d20$c7a3580a@swcenter.sec.samsung.co.kr>
	<200610241141.17312.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200610241141.17312.david-b@pacbell.net>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [061024 22:00]:
> On Sunday 22 October 2006 9:44 pm, Kyungmin Park wrote:
> 
> > > -------
> > > NOTE:  this is just a cleaned up version of the code from 
> > > Kyungmin, I don't have it behaving yet on H4, and didn't 
> > > re-test on e.g. OSK.
> > 
> > There's missing patch. We have to modify following line.
> 
> Good catch.   It got tangled up in the H4 support patch, which I
> didn't send, since that also needs "select ISP1301_OMAP" when the
> OTG port is defined.
> 
> Tony, feel free to merge this patch too.  :)

OK, pushed Kyuingmin's patch you cleaned up + Kyungmin's fix as one
patch.

Regards,

Tony
