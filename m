From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Make H2 board file compile without irda warning
Date: Fri, 24 Feb 2006 17:10:19 -0800
Message-ID: <20060225011019.GD5116@atomide.com>
References: <9268368b0602220540n1cfd8a14oc83d805823821eb0@mail.gmail.com>
	<20060222161650.26516.qmail@web32913.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060222161650.26516.qmail@web32913.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060222 09:26]:
> --- Daniel Petrini <d.pensator@gmail.com> wrote:
> 
> > 
> >  Humm, my first idea was exactly like this but I tried to avoid
> > another #ifdef..
> >  So what about this new approach, which still avoids #ifdefs although
> >  with expense of one flag ?
> > 
> 
> I am now in confusion :). I like your patch too, but I thought that
> adding #ifdef in board-* files is no harm. So, let's Tony speak :)

Both work, but let's use the smaller codesize one at the expense of
one ifdef :) I'll push Komal's patch today.

Tony
