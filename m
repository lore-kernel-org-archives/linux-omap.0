From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mtd/cmdlinepart.c: remove static declaration of
	mtdpart_setup
Date: Thu, 1 Feb 2007 10:20:05 -0800
Message-ID: <20070201182004.GF19495@atomide.com>
References: <85odoenq89.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <85odoenq89.fsf@orfeo.duckcorp.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Arnaud Patard <arnaud.patard@rtp-net.org> [070201 02:16]:
> Hi,
> 
> The n770 (and maybe the n800 too) are using a tag for setting the
> mtd partition layout and not the command line. The commit in linus tree
> ddacff1f20fc5c96cc73e2975258e05d298c97cc is setting mtdpart_setup as
> static, preventing its use in the omap-hw driver and thus, is breaking
> the build.
> So, here's a patch to revert it. imho we'll have to carry it in the omap
> tree until the omap-hw driver is merged.

Pushing today.

Regards,

Tony
