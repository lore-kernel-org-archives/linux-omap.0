From: Tony Lindgren <tony@atomide.com>
Subject: Build fails with SLOB in next
Date: Thu, 8 Mar 2018 09:28:49 -0800
Message-ID: <20180308172849.GO5799@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Alexander Viro <viro@zeniv.linux.org.uk>, Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@techsingularity.net>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Looks like commit 8b1747684ff8 ("dcache: account external names as
indirectly reclaimable memory") caused build fail if SLOB is selected:

fs/dcache.c: In function '__d_free_external':
fs/dcache.c:278:22: error: implicit declaration of function
'kmalloc_index'; did you mean 'kmalloc_ node'?
[-Werror=implicit-function-declaration]
        -kmalloc_size(kmalloc_index(bytes)));
	                      ^~~~~~~~~~~~~

Is this already fixed somewhere?

Regards,

Tony
