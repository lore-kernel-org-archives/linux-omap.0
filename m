From: tony@atomide.com
Subject: Re: [PATCH] mkuboot.sh: quit elegantly on not finding mkimage
Date: Wed, 16 May 2007 08:18:39 -0700
Message-ID: <20070516151838.GC20297@atomide.com>
References: <782515bb0705081717jaea0fdbj3b4cbd3325fcbbe3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <782515bb0705081717jaea0fdbj3b4cbd3325fcbbe3@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: nishanth menon <menon.nishanth@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* nishanth menon <menon.nishanth@gmail.com> [070508 17:18]:
> Hi All,
> A tiny patch: when mkimage is not found return 1 instead of 0. helps
> to ensure that the make uImage fails if mkimage is not in path.
> 
> Could not find a vgers list for scripts.. hence posting here..

You should post this to LKML as u-boot is cross platform. Or send it
to the u-boot maintainer to send it to LKML.

Tony
