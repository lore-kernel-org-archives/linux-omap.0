From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Git tree updated
Date: Fri, 16 Mar 2007 19:57:14 +0100
Message-ID: <45FAE88A.1090904@googlemail.com>
References: <20070301143330.GF26097@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070301143330.GF26097@atomide.com>
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

Tony Lindgren wrote:
> Now we have following branches:
> 
> linus
>      \
>       omap-fixes
>                 \
>                  omap-upstream
>                               \
>                                omap-drivers
>                                            \
>                                             master
> 
> The branches have following purpose:
> 
> linus		Linus' mainline tree
> omap-fixes	Queue of omap fixes for -rcN series

Looks like this starts to work:

http://www.ussg.iu.edu/hypermail/linux/kernel/0703.2/0246.html

http://www.uwsg.iu.edu/hypermail/linux/kernel/0703.0/2536.html

-> search for "OMAP"

:)

How do the changes in omap-fixes find their way to Linus? 
Does Linus pull directly from omap-fixes? How is this triggered?

Cheers

Dirk
