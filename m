From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [PATCH] MUSB_HDRC: Get rid of pr_*() and printk() clauses
Date: Wed, 15 Aug 2007 12:29:17 -0400
Message-ID: <31e679430708150929v794b4a64h71e096f9f7c044e4@mail.gmail.com>
References: <1187186887430-git-send-email-felipe.lima@indt.org.br>
	<200708150913.58968.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200708150913.58968.david-b@pacbell.net>
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

Hi,

On 8/15/07, David Brownell <david-b@pacbell.net> wrote:
> On Wednesday 15 August 2007, Felipe Balbi wrote:
> > * Convert pr_*() to dev_*() macros
>
> That's not always a win, especially in IRQ paths where the extra
> text of dev_*() can introduce new timings ... but I won't eyeball
> these changes, they're likely at least safe.  It's appropriate to
> use the pr_*() calls in cases where "there can be only one", so
> there's no value in adding the driver name and a device ID.
>
>
> > * Convert printk() to dev_*() macros
>
> Similarly ... printk() to pr_*() might be better, but I won't
> eyeball them.
>
>
> > * Convert missing pr_*() to {info, err, dbg}() macros
>
> No, please -- don't use those ancient USB-only macros, they're
> for legacy code.  Plus, you're using them wrong:
>
> > -pr_debug("TEST_J\n");
> > +dbg("TEST_J\n");

Oh... sorry forgot to remove that extra '\n' from the message. I'll
fix this, maybe getting back to pr_*. Do you have any other comments
about this? How should I do it right??

Thanks Dave.

>
> We don't want *TWO* newlines after each diagnostic message.
> Plus, those aren't "missing" at all...
>
> - Dave
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
