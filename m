From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/1] PM: Making bdi threads non-freezable
Date: Tue, 3 Nov 2009 22:03:57 +0100
Message-ID: <200911032203.57757.rjw@sisk.pl>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE1EBC66@dbde02.ent.ti.com> <200911021943.49943.rjw@sisk.pl> <B85A65D85D7EB246BE421B3FB0FBB59301DE1EC179@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE1EC179@dbde02.ent.ti.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 03 November 2009, Dasgupta, Romit wrote:
> 
> > Subject: Re: [PATCH 1/1] PM: Making bdi threads non-freezable
> > 
> > On Monday 02 November 2009, Dasgupta, Romit wrote:
> > > Fixes the case when bdi threads are in the refrigerator but file system sync
> > > can happen after this. This is possible in MMC when
> > CONFIG_MMC_UNSAFE_RESUME is
> > > not set.
> > 
> > What's going to happen if we attemt to suspend the underlying block device(s)
> > when the bdi thread are doing their job?  Is there any synchronisation
> > mechanism for that?
> > 
> There is no explicit synchronization AFAICT. However, it looks like the call
> to 'del_gendisk' would invoke 'sync_filesystem' down the line.
> 'sync_filesystem' would end with synchronous writes of inodes followed by a
> call to '__sync_blockddev'.

However, that runs concurrently with respect to the suspend thread, AFAICS, so
I wonder if there's anything to make the suspend thread wait for these
operations to complete.  If there's nothing like that, we can't really allow
the bdi threads to run in parallel with the suspend thread.

Thanks,
Rafael
