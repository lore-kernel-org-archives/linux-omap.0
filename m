From: tony@atomide.com
Subject: Re: [PATCH] ARM: OMAP: ISP1301 workqueue fixes
Date: Tue, 2 Jan 2007 12:34:27 -0800
Message-ID: <20070102203427.GC9733@atomide.com>
References: <45937A00.1070803@gmail.com>
	<200612281205.37642.david-b@pacbell.net>
	<4594D386.2050904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <4594D386.2050904@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [061229 00:44]:
> David Brownell wrote:
> >On Thursday 28 December 2006 12:02 am, Dirk Behme wrote:
> >
> >>static void
> >>-isp1301_work(void *data)
> >>+isp1301_work(struct work_struct *data)
> >>{
> >>-       struct isp1301  *isp = data;
> >>+       struct isp1301  *isp = (struct isp1301 *)data;
> >>       int             stop;
> >
> >
> >Clearly incorrect.  It should use container_of().  The work_struct
> >is NOT the first member of that struct... this will be oopsing.
> 
> Yes, I see. Thanks!
> 
> So, next attempt ;) Below both, ISP1301 and board-h3. Again,
> only checked for compilation.

Pushing as two patches.

Tony
