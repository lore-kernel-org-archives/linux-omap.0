From: Evgeniy Polyakov <zbr@ioremap.net>
Subject: Re: [PATCH 2/2] ARM: omap_hdq: use wait_event_timeout to wait for
 read to complete.
Date: Wed, 2 May 2012 01:42:19 +0400
Message-ID: <20120501214219.GB15560@ioremap.net>
References: <20120425124153.2afa318b@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120425124153.2afa318b@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 25, 2012 at 12:41:53PM +1000, NeilBrown (neilb@suse.de) wrote:
> There is no gain in having a loop - there is no risk of missing the
> interrupt with wait_event_timeout.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Both patches look good, thank you
Feel free to add my ack if needed

-- 
	Evgeniy Polyakov
