From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [PATCH 11/12] musb_hdrc: Allow suspend if host is already
	suspended
Date: Thu, 11 Oct 2007 23:38:13 +0300
Message-ID: <31e679430710111338g5489feaxc1b0427bbb451b7a@mail.gmail.com>
References: <1192122325531-git-send-email-tony@atomide.com>
	<11921223311131-git-send-email-tony@atomide.com>
	<11921223321890-git-send-email-tony@atomide.com>
	<11921223331118-git-send-email-tony@atomide.com>
	<11921223352146-git-send-email-tony@atomide.com>
	<11921223372253-git-send-email-tony@atomide.com>
	<11921223381405-git-send-email-tony@atomide.com>
	<11921223392718-git-send-email-tony@atomide.com>
	<31e679430710111307s57a7f415n9b3ef2cfefe60c9e@mail.gmail.com>
	<20071011202139.758331E8CE1@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071011202139.758331E8CE1@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Content-Disposition: inline
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

On 10/11/07, David Brownell <david-b@pacbell.net> wrote:

<snip>

> > Should we allow this ? If it's already suspended it doesn't make sense
> > suspending again.
>
> Allow it.  The invariant is that when the call returns,
> the bus has been suspended.

K... thanks for clarification. ;-)


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
