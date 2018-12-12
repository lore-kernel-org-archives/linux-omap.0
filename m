From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: Re: Regression in next-20181211 with fsverity changes
Date: Wed, 12 Dec 2018 09:46:27 +0530
Message-ID: <3171217.2PqYythArb@localhost.localdomain>
References: <20181211191220.GW6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211191220.GW6707@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday, December 12, 2018 12:42:20 AM IST Tony Lindgren wrote:
> Hi,
> 
> Looks like commit 4de97efb578a ("fsverity: Move verity status check
> to fsverity_file_open") causes a boot regression for me with root
> on ext4 SDIO card, see below.
> 

fsverity_file_open() used to incorrectly return -EOPNOTSUPP for non-fsverity
files on kernels built without fsverity support. This bug has been fixed in
the V4 patchset <https://marc.info/?l=linux-ext4&m=154458767124953&w=2>.

-- 
chandan
