From: Lauri Leukkunen <lauri.leukkunen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Add TI TSC2005 Touchscreen driver
Date: Tue, 9 Dec 2008 15:17:05 +0200
Message-ID: <20081209131705.GC6667@pure.research.nokia.com>
References: <5d5443650812080949h5aff6010mb7341f581841f126@mail.gmail.com>
	<20081208182648.GA9740@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20081208182648.GA9740-QabhHTsIXMSnlFQ6Q1D1Y0B+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: ext Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Mailing List" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 08/12/08 19:26 +0100, ext Sam Ravnborg wrote:
> > Add Texas Instruments TSC2005 chip touchscreen driver.
> > 
> > Signed-off-by: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Hi Trilok.
> A few nitpicks below.
> 
> In general a very clean written driver with adequate comments - nice work!

Umm, isn't this code mostly written by Nokia? At least I remember modifying
some of it, and this version looks like Konsta Karsisto might be the last
person touching it. Originally I think it's written by Imre Deak, probably
based on the tsc2301 code.

/lauri


------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
