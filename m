From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: Re: Regression in next with apps hanging with vm_fault_t
Date: Tue, 11 Sep 2018 00:17:45 +0530
Message-ID: <CAFqt6zaRFW+bwVmWbMQ9ni9VJzsa1QMPRLFDCE6X0yQbvbPukw@mail.gmail.com>
References: <20180910182143.GW5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910182143.GW5662@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca, "Darrick J. Wong" <darrick.wong@oracle.com>, Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com, Andrew Morton <akpm@linux-foundation.org>, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 10, 2018 at 11:51 PM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> I'm seeing a regression with Linux next with commit 7b6ec2ae877a
> ("fs: convert return type int to vm_fault_t") where apps can just
> hang.
>
> The reproducable test case I have is to remove a distro package
> and then add it back where adding the package back just hangs and
> the package file seems corrupted.
>
> This is with ext4 rootfs on MMC, NFSroot does not have this
> issue. Any ideas?

This is a bad commit and there is a plan to remove it from all the tree.
Not sure why it is still showing in linux-next tree.
