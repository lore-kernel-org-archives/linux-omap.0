From: tony@atomide.com
Subject: Re: [PATCH] Convert OSS aic23 to mutex
Date: Fri, 28 Apr 2006 03:29:18 -0700
Message-ID: <20060428102917.GI31797@atomide.com>
References: <443407FB.2060304@gmail.com> <20060405190013.GA5532@nokia.com>
	<4435296C.5040304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <4435296C.5040304@gmail.com>
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

* Dirk Behme <dirk.behme@googlemail.com> [060406 10:32]:
> Paul Mundt wrote:
> >Are you sure this doesn't need an #include <linux/mutex.h>? All of the
> >other conversions so far have..
> 
> It compiles without extra linux/mutex.h because
> linux/sound.h includes linux/fs.h which includes
> linux/mutex.h. But you are right, include linux/mutex.h is
> cleaner. Please find updated patch in attachment.

Thanks, pushing today.

Tony
