From: Tony Lindgren <tony@atomide.com>
Subject: Regression in next with apps hanging with vm_fault_t
Date: Mon, 10 Sep 2018 11:21:43 -0700
Message-ID: <20180910182143.GW5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, "Darrick J. Wong" <darrick.wong@oracle.com>, Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kemi Wang <kemi.wang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

I'm seeing a regression with Linux next with commit 7b6ec2ae877a
("fs: convert return type int to vm_fault_t") where apps can just
hang.

The reproducable test case I have is to remove a distro package
and then add it back where adding the package back just hangs and
the package file seems corrupted.

This is with ext4 rootfs on MMC, NFSroot does not have this
issue. Any ideas?

Regards,

Tony
