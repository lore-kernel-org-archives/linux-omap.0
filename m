From: Daniel Walker <dwalker@mvista.com>
Subject: Re: omap1710 upstream ?
Date: Thu, 18 May 2006 06:34:54 -0700
Message-ID: <1147959295.17117.17.camel@c-67-180-134-207.hsd1.ca.comcast.net>
References: <1147890163.13483.6.camel@dwalker1.mvista.com>
	<20060518073202.GB4013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060518073202.GB4013@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thu, 2006-05-18 at 00:32 -0700, Tony Lindgren wrote:
> * Daniel Walker <dwalker@mvista.com> [060517 11:22]:
> > 
> > 	I was wondering if there was any time frame when omap1710 might be
> > going upstream ? Is there still work that needs to be done to make it
> > acceptable , or is it just not a top priority ?
> 
> In our tree omap1710 is mostly same as omap16xx. There are only few
> places where we need to check for omap1710 vs omap16xx.
> 
> Most of the core omap code is in sync with mainline tree. Many device
> drivers are not integrated yet.

The one thing I notice that's missing is the defconfig . The only
upstream defconfig is 1610 .

Daniel
