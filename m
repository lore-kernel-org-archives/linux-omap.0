From: Tony Lindgren <tony@atomide.com>
Subject: NFSroot regression in next with handle inode->i_version
Date: Tue, 9 Jan 2018 13:01:21 -0800
Message-ID: <20180109210121.GX3875@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi all,

Commit 4b5bd6a8e7cf ("fs: handle inode->i_version more efficiently")
causes NFSroot to not boot to login in Linux next on my ARM boxes.

Also the attempted boot seems really slow, so the reason for not
reaching login might be not being able to kick the watchdog as
I'm seeing spontaneous reboots.

Reverting the patch makes things work again, any ideas?

Can you guys please revert this in next while this is being
investigated?

Regards,

Tony
