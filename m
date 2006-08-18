From: Brian Swetland <swetland@google.com>
Subject: Re: Building kenel error
Date: Fri, 18 Aug 2006 13:15:17 -0700
Message-ID: <20060818201517.GA4066@localhost.localdomain>
References: <EA12F909C0431D458B9D18A176BEE4A5072DABC7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5072DABC7@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

["Woodruff, Richard" <r-woodruff2@ti.com>]
> 
> > I never had success of using gcc-4.0.2 and later on 2.6.16/17 kernel.
> So
> > I just stick with the older gcc-3.4.1. Which version of tool chain are
> > you using for 2.6.16 or 2.6.17 kernel? Any advantages of using the
> later
> > version of the compiler?
> > Thanks,
> > kwan
> 
> We have to use several different versions.  Currently I use 3.4.0,
> 3.4.3, and 3.3.1 on older kernels.  On the latest kernels we will use
> 4.1.0.  We have built these, gotten them from a vendor, or gotten from
> www.codesourcery.com .
> 
> One of the main reasons for using CodeSourcery based tool chains is they
> provide newer ARM support though ARMv7 (including VFP & VFP2).  If you
> are doing gaming with the OMAP2 3d core it can provide a nice boost.

What is codegen and stability like?  I suffered through a number of
pre-3.x versions while working at Danger and have found the 3.3.x and
3.4.x toolchains to be pretty solid.  I had heard that the changes in 
4.x resulted in big improvements in x86 codegen but other platforms 
suffered a bit -- any truth to this?  New instruction set support is
very cool, but I'm curious how the baseline arm and thumb support has 
held up. 

Brian
