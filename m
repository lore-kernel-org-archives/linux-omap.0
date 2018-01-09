From: Jeff Layton <jlayton@redhat.com>
Subject: Re: NFSroot regression in next with handle inode->i_version
Date: Tue, 09 Jan 2018 16:11:56 -0500
Message-ID: <1515532316.3571.20.camel@redhat.com>
References: <20180109210121.GX3875@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180109210121.GX3875@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2018-01-09 at 13:01 -0800, Tony Lindgren wrote:
> Hi all,
> 
> Commit 4b5bd6a8e7cf ("fs: handle inode->i_version more efficiently")
> causes NFSroot to not boot to login in Linux next on my ARM boxes.
> 
> Also the attempted boot seems really slow, so the reason for not
> reaching login might be not being able to kick the watchdog as
> I'm seeing spontaneous reboots.
> 
> Reverting the patch makes things work again, any ideas?
> 
> Can you guys please revert this in next while this is being
> investigated?
> 
> Regards,
> 
> Tony

Hi Tony,

Krzysztof Kozlowski reported this late last week, and I just pushed an
updated branch earlier this morning that should fix this. It looks like
the current linux-next HEAD has the fixed patchset now too. Let me know
if that doesn't help you.

Thanks,
-- 
Jeff Layton <jlayton@redhat.com>
