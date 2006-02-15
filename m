From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: clk_get kernel dump
Date: Wed, 15 Feb 2006 06:37:15 -0800 (PST)
Message-ID: <20060215143716.48574.qmail@web32901.mail.mud.yahoo.com>
References: <20060214175603.GE7135@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060214175603.GE7135@atomide.com>
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

--- Tony Lindgren <tony@atomide.com> wrote:

> 
> Might be the common DSP code trying to set NULL clocks on omap2. I've
> patched the clock framework to check that:
> 
>
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=8fc55a5be4a212efc51a335ddcd5ba066f46de6c
> 
> So updating to current git tree should help.

My tree is having this patch and clock fwk is latest as per the git
tree. But the dump seems to coming from debug_mutex_waiter_free(...)
function. 

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
