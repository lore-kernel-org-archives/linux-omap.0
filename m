From: Tony Lindgren <tony@atomide.com>
Subject: Re: NFSroot regression in next with handle inode->i_version
Date: Tue, 9 Jan 2018 13:21:47 -0800
Message-ID: <20180109212147.GY3875@atomide.com>
References: <20180109210121.GX3875@atomide.com>
 <1515532316.3571.20.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1515532316.3571.20.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jan Kara <jack@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Jeff Layton <jlayton@redhat.com> [180109 21:14]:
> On Tue, 2018-01-09 at 13:01 -0800, Tony Lindgren wrote:
> > Commit 4b5bd6a8e7cf ("fs: handle inode->i_version more efficiently")
> > causes NFSroot to not boot to login in Linux next on my ARM boxes.

> Krzysztof Kozlowski reported this late last week, and I just pushed an
> updated branch earlier this morning that should fix this. It looks like
> the current linux-next HEAD has the fixed patchset now too. Let me know
> if that doesn't help you.

OK great, thanks for the update. I'll test again tomorrow and will
whine again if I'm seeing issues :)

Regards,

Tony
